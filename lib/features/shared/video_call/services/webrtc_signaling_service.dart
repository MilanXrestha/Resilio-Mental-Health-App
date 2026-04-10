import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef SignalingCallback = void Function(dynamic data);

class WebRTCSignalingService {
  IO.Socket? _socket;
  
  // Callbacks for WebRTC events
  SignalingCallback? onRemoteUserJoined;
  SignalingCallback? onRemoteUserLeft;
  SignalingCallback? onReceiveOffer;
  SignalingCallback? onReceiveAnswer;
  SignalingCallback? onReceiveIceCandidate;

  /// Connect to the Node/Socket.IO backend
  void connect(String url, String appointmentId, String userId) {
    _socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket!.connect();

    _socket!.onConnect((_) {
      debugPrint('WebRTC Client connected to socket server');
      // Join the room defined by appointmentId
      _socket!.emit('join-room', {
        'roomId': appointmentId,
        'userId': userId,
      });
    });

    _socket!.on('user-joined', (data) {
      debugPrint('User joined room: $data');
      if (onRemoteUserJoined != null) onRemoteUserJoined!(data);
    });

    _socket!.on('user-left', (data) {
      debugPrint('User left room: $data');
      if (onRemoteUserLeft != null) onRemoteUserLeft!(data);
    });

    _socket!.on('receive-offer', (data) {
      if (onReceiveOffer != null) onReceiveOffer!(data);
    });

    _socket!.on('receive-answer', (data) {
      if (onReceiveAnswer != null) onReceiveAnswer!(data);
    });

    _socket!.on('receive-ice-candidate', (data) {
      if (onReceiveIceCandidate != null) onReceiveIceCandidate!(data);
    });
  }

  void sendOffer(String roomId, String targetUserId, RTCSessionDescription offer) {
    _socket?.emit('offer', {
      'roomId': roomId,
      'targetUserId': targetUserId,
      'offer': {
        'type': offer.type,
        'sdp': offer.sdp,
      }
    });
  }

  void sendAnswer(String roomId, String targetUserId, RTCSessionDescription answer) {
    _socket?.emit('answer', {
      'roomId': roomId,
      'targetUserId': targetUserId,
      'answer': {
        'type': answer.type,
        'sdp': answer.sdp,
      }
    });
  }

  void sendIceCandidate(String roomId, String targetUserId, RTCIceCandidate candidate) {
    _socket?.emit('ice-candidate', {
      'roomId': roomId,
      'targetUserId': targetUserId,
      'candidate': {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      }
    });
  }

  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}
