import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../../../core/di/injection.dart';

typedef SignalingCallback = void Function(dynamic data);

/// HTTP-polling based WebRTC signaling.
/// Replaces the Socket.IO server — works with the Vercel REST backend.
///
/// The backend stores signals in a `webrtc_signals` Supabase table.
/// See webrtc-signal-controller.js for the required SQL.
class WebRTCSignalingService {
  final Dio _dio = getIt<Dio>();

  String? _roomId;
  String? _userId;
  Timer? _pollTimer;
  DateTime _lastPollAt = DateTime.fromMillisecondsSinceEpoch(0);
  bool _polling = false;
  bool _firstPoll = true;
  bool _disposed = false;

  // ── Callbacks ──────────────────────────────────────────────────────────────
  SignalingCallback? onRemoteUserJoined;
  SignalingCallback? onRemoteUserLeft;
  SignalingCallback? onReceiveOffer;
  SignalingCallback? onReceiveAnswer;
  SignalingCallback? onReceiveIceCandidate;
  SignalingCallback? onRoomPeers;

  bool get isConnected => !_disposed && (_pollTimer?.isActive ?? false);

  // ── Public API (mirrors old Socket.IO interface) ───────────────────────────

  void connect(String serverUrl, String roomId, String userId) {
    _roomId = roomId;
    _userId = userId;
    _firstPoll = true;
    // Set last-poll to 60 s ago so the first poll fetches existing peers
    _lastPollAt = DateTime.now().subtract(const Duration(seconds: 60));

    // Announce presence
    _emit('join', {});

    // Start polling at 500 ms intervals
    _pollTimer = Timer.periodic(const Duration(milliseconds: 500), (_) => _poll());
    debugPrint('[Signaling] Connected to room $roomId as $userId (HTTP polling)');
  }

  void sendOffer(
    String roomId,
    String targetUserId,
    RTCSessionDescription offer,
    String fromUserId,
  ) {
    _emit('offer', {
      'offer': {'type': offer.type, 'sdp': offer.sdp},
      'targetUserId': targetUserId,
    });
  }

  void sendAnswer(
    String roomId,
    String targetUserId,
    RTCSessionDescription answer,
    String fromUserId,
  ) {
    _emit('answer', {
      'answer': {'type': answer.type, 'sdp': answer.sdp},
      'targetUserId': targetUserId,
    });
  }

  void sendIceCandidate(
    String roomId,
    String targetUserId,
    RTCIceCandidate candidate,
    String fromUserId,
  ) {
    _emit('ice_candidate', {
      'candidate': {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      },
      'targetUserId': targetUserId,
    });
  }

  void leaveRoom(String roomId, String userId) {
    _emit('leave', {});
    _stop();
  }

  void dispose() {
    _stop();
    _disposed = true;
  }

  // ── Internals ──────────────────────────────────────────────────────────────

  void _stop() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  Future<void> _emit(String eventType, Map<String, dynamic> payload) async {
    if (_roomId == null || _userId == null) return;
    try {
      await _dio.post('/webrtc/signal', data: {
        'roomId': _roomId,
        'fromUserId': _userId,
        'eventType': eventType,
        'payload': payload,
      });
    } catch (e) {
      debugPrint('[Signaling] emit $eventType error: $e');
    }
  }

  Future<void> _poll() async {
    if (_polling || _disposed || _roomId == null || _userId == null) return;
    _polling = true;
    try {
      final since = _lastPollAt.toUtc().toIso8601String();
      _lastPollAt = DateTime.now();

      final res = await _dio.get(
        '/webrtc/signal/$_roomId',
        queryParameters: {'since': since, 'excludeUserId': _userId},
      );

      final signals = (res.data['signals'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();

      if (signals.isEmpty) {
        _firstPoll = false;
        return;
      }

      // On the first poll, treat any existing 'join' signals as already-present peers
      if (_firstPoll) {
        _firstPoll = false;
        final existingPeers = signals
            .where((s) => s['event_type'] == 'join')
            .map((s) => {'userId': s['from_user_id']})
            .toList();
        if (existingPeers.isNotEmpty) {
          // Fire onRoomPeers so the caller creates the offer
          onRoomPeers?.call({'peers': existingPeers});
          // Filter out join events so we don't double-fire onRemoteUserJoined
          for (final s in signals) {
            if (s['event_type'] != 'join') _handleSignal(s);
          }
          return;
        }
      }

      for (final s in signals) {
        _handleSignal(s);
      }
    } catch (e) {
      debugPrint('[Signaling] poll error: $e');
    } finally {
      _polling = false;
    }
  }

  void _handleSignal(Map<String, dynamic> signal) {
    final type = signal['event_type'] as String?;
    final payload = (signal['payload'] as Map<dynamic, dynamic>?)
            ?.cast<String, dynamic>() ??
        {};
    final fromUserId = signal['from_user_id'] as String?;

    debugPrint('[Signaling] received $type from $fromUserId');

    switch (type) {
      case 'join':
        onRemoteUserJoined?.call({'userId': fromUserId});
        break;
      case 'leave':
        onRemoteUserLeft?.call({'userId': fromUserId});
        break;
      case 'offer':
        // Only handle if targeted at us or broadcast
        final target = payload['targetUserId'] as String?;
        if (target != null && target != _userId) return;
        onReceiveOffer?.call({
          'offer': payload['offer'],
          'fromUserId': fromUserId,
        });
        break;
      case 'answer':
        final target = payload['targetUserId'] as String?;
        if (target != null && target != _userId) return;
        onReceiveAnswer?.call({
          'answer': payload['answer'],
          'fromUserId': fromUserId,
        });
        break;
      case 'ice_candidate':
        final target = payload['targetUserId'] as String?;
        if (target != null && target != _userId) return;
        onReceiveIceCandidate?.call({
          'candidate': payload['candidate'],
          'fromUserId': fromUserId,
        });
        break;
    }
  }
}
