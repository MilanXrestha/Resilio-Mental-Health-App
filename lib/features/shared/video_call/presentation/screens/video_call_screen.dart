import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../services/webrtc_signaling_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCallScreen extends StatefulWidget {
  final String appointmentId;
  final String currentUserId;
  // This could be fetched from env config
  final String serverUrl = 'http://10.0.2.2:3000'; 

  const VideoCallScreen({
    super.key,
    required this.appointmentId,
    required this.currentUserId,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  RTCPeerConnection? _peerConnection;
  late WebRTCSignalingService _signaling;

  bool _inCall = false;
  bool _audioMuted = false;
  bool _videoMuted = false;
  String? _remoteUserId;

  final Map<String, dynamic> configuration = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'}, // Google Public STUN
      {'urls': 'stun:stun1.l.google.com:19302'}, // Google Public STUN 2
      {
        'urls': 'turn:openrelay.metered.ca:80', // public open relay turn server
        'username': 'openrelayproject',
        'credential': 'openrelayproject',
      },
    ],
    'sdpSemantics': 'unified-plan',
  };

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _initSignaling();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    _openUserMedia();
  }

  void _initSignaling() {
    _signaling = WebRTCSignalingService();

    _signaling.onRemoteUserJoined = (data) {
      _remoteUserId = data['userId'];
      _createOffer();
    };

    _signaling.onRemoteUserLeft = (data) {
      if (_remoteUserId == data['userId']) {
        _remoteRenderer.srcObject = null;
        _remoteUserId = null;
        setState(() {});
      }
    };

    _signaling.onReceiveOffer = (data) async {
      final offer = data['offer'];
      _remoteUserId = data['fromUserId'];
      await _createAnswer(RTCSessionDescription(offer['sdp'], offer['type']));
    };

    _signaling.onReceiveAnswer = (data) async {
      final answer = data['answer'];
      if (_peerConnection != null) {
        await _peerConnection!.setRemoteDescription(
          RTCSessionDescription(answer['sdp'], answer['type']),
        );
      }
    };

    _signaling.onReceiveIceCandidate = (data) async {
      final cand = data['candidate'];
      if (_peerConnection != null) {
        await _peerConnection!.addCandidate(
          RTCIceCandidate(cand['candidate'], cand['sdpMid'], cand['sdpMLineIndex']),
        );
      }
    };

    _signaling.connect(widget.serverUrl, widget.appointmentId, widget.currentUserId);
  }

  Future<void> _openUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      }
    };

    MediaStream stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer.srcObject = stream;
    _localStream = stream;

    await _createPeerConnection();

    setState(() {
      _inCall = true;
    });
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection(configuration);

    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      if (_remoteUserId != null) {
        _signaling.sendIceCandidate(widget.appointmentId, _remoteUserId!, candidate);
      }
    };

    _peerConnection!.onTrack = (event) {
      if (event.track.kind == 'video') {
        _remoteRenderer.srcObject = event.streams[0];
        setState(() {});
      }
    };

    // Add local tracks to peer connection
    _localStream?.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });
  }

  Future<void> _createOffer() async {
    if (_peerConnection == null || _remoteUserId == null) return;
    
    RTCSessionDescription offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    
    _signaling.sendOffer(widget.appointmentId, _remoteUserId!, offer);
  }

  Future<void> _createAnswer(RTCSessionDescription offer) async {
    if (_peerConnection == null || _remoteUserId == null) return;

    await _peerConnection!.setRemoteDescription(offer);
    RTCSessionDescription answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);
    
    _signaling.sendAnswer(widget.appointmentId, _remoteUserId!, answer);
  }

  void _toggleAudio() {
    if (_localStream != null) {
      final audioTrack = _localStream!.getAudioTracks().first;
      audioTrack.enabled = !audioTrack.enabled;
      setState(() => _audioMuted = !audioTrack.enabled);
    }
  }

  void _toggleVideo() {
    if (_localStream != null) {
      final videoTrack = _localStream!.getVideoTracks().first;
      videoTrack.enabled = !videoTrack.enabled;
      setState(() => _videoMuted = !videoTrack.enabled);
    }
  }

  void _hangUp() {
    _localStream?.getTracks().forEach((track) => track.stop());
    _peerConnection?.close();
    _signaling.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _hangUp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Remote Video
            Positioned.fill(
              child: _remoteRenderer.srcObject != null
                  ? RTCVideoView(_remoteRenderer, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover)
                  : const Center(
                      child: Text('Waiting for therapist...', style: TextStyle(color: Colors.white)),
                    ),
            ),
            
            // Local Video (PiP)
            if (_inCall)
              Positioned(
                right: 20.w,
                top: 20.h,
                width: 100.w,
                height: 150.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: RTCVideoView(_localRenderer, mirror: true, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
                ),
              ),

            // Controls
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ControlButton(
                    icon: _audioMuted ? Icons.mic_off : Icons.mic,
                    color: _audioMuted ? Colors.red : Colors.white24,
                    onTap: _toggleAudio,
                  ),
                  _ControlButton(
                    icon: Icons.call_end,
                    color: Colors.red,
                    iconColor: Colors.white,
                    size: 64.r,
                    onTap: _hangUp,
                  ),
                  _ControlButton(
                    icon: _videoMuted ? Icons.videocam_off : Icons.videocam,
                    color: _videoMuted ? Colors.red : Colors.white24,
                    onTap: _toggleVideo,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;
  final double? size;

  const _ControlButton({
    required this.icon,
    required this.color,
    this.iconColor = Colors.white,
    required this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: size ?? 48.r,
        height: size ?? 48.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(icon, color: iconColor, size: (size ?? 48.r) * 0.5),
      ),
    );
  }
}
