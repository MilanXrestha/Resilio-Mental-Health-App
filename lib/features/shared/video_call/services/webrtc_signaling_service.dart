import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef SignalingCallback = void Function(dynamic data);

class WebRTCSignalingService {
  io.Socket? _socket;

  SignalingCallback? onRemoteUserJoined;
  SignalingCallback? onRemoteUserLeft;
  SignalingCallback? onReceiveOffer;
  SignalingCallback? onReceiveAnswer;
  SignalingCallback? onReceiveIceCandidate;
  SignalingCallback? onRoomPeers;

  bool get isConnected => _socket?.connected ?? false;

  void connect(String serverUrl, String roomId, String userId) {
    _socket = io.io(
      serverUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket!.connect();

    _socket!.onConnect((_) {
      debugPrint('[Signaling] Connected to $serverUrl');
      _socket!.emit('join-room', {'roomId': roomId, 'userId': userId});
    });

    _socket!.onConnectError((err) => debugPrint('[Signaling] Connect error: $err'));
    _socket!.onDisconnect((_) => debugPrint('[Signaling] Disconnected'));

    _socket!.on('user-joined', (data) {
      debugPrint('[Signaling] user-joined: $data');
      onRemoteUserJoined?.call(data);
    });

    _socket!.on('user-left', (data) {
      debugPrint('[Signaling] user-left: $data');
      onRemoteUserLeft?.call(data);
    });

    _socket!.on('receive-offer', (data) {
      debugPrint('[Signaling] receive-offer from ${data['fromUserId']}');
      onReceiveOffer?.call(data);
    });

    _socket!.on('receive-answer', (data) {
      debugPrint('[Signaling] receive-answer');
      onReceiveAnswer?.call(data);
    });

    _socket!.on('receive-ice-candidate', (data) {
      onReceiveIceCandidate?.call(data);
    });

    _socket!.on('room-peers', (data) {
      debugPrint('[Signaling] room-peers: $data');
      onRoomPeers?.call(data);
    });
  }

  void sendOffer(
    String roomId,
    String targetUserId,
    RTCSessionDescription offer,
    String fromUserId,
  ) {
    _socket?.emit('offer', {
      'roomId': roomId,
      'targetUserId': targetUserId,
      'fromUserId': fromUserId,
      'offer': {'type': offer.type, 'sdp': offer.sdp},
    });
  }

  void sendAnswer(
    String roomId,
    String targetUserId,
    RTCSessionDescription answer,
    String fromUserId,
  ) {
    _socket?.emit('answer', {
      'roomId': roomId,
      'targetUserId': targetUserId,
      'fromUserId': fromUserId,
      'answer': {'type': answer.type, 'sdp': answer.sdp},
    });
  }

  void sendIceCandidate(
    String roomId,
    String targetUserId,
    RTCIceCandidate candidate,
    String fromUserId,
  ) {
    _socket?.emit('ice-candidate', {
      'roomId': roomId,
      'targetUserId': targetUserId,
      'fromUserId': fromUserId,
      'candidate': {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      },
    });
  }

  void leaveRoom(String roomId, String userId) {
    _socket?.emit('leave-room', {'roomId': roomId, 'userId': userId});
  }

  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}
