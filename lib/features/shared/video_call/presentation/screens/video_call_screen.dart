import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../services/webrtc_signaling_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String _resolveServerUrl() {
  const prod = String.fromEnvironment('WEBRTC_SERVER_URL');
  if (prod.isNotEmpty) return prod;
  return 'http://10.0.2.2:3000';
}

class VideoCallScreen extends StatefulWidget {
  final String appointmentId;
  final String currentUserId;

  const VideoCallScreen({
    super.key,
    required this.appointmentId,
    required this.currentUserId,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen>
    with TickerProviderStateMixin {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  RTCPeerConnection? _peerConnection;
  late WebRTCSignalingService _signaling;

  // ── Call state ────────────────────────────────────────────────────────────
  bool _micMuted = false;
  bool _speakerOn = true;
  bool _remoteConnected = false;
  String? _remoteUserId;

  // Audio-first: start voice-only, user can enable camera anytime
  bool _cameraOn = false;
  bool _remoteCameraOn = false;

  Timer? _timer;
  int _elapsedSeconds = 0;

  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;
  late AnimationController _fadeCtrl;

  // Show/hide controls overlay
  bool _showControls = true;
  Timer? _hideControlsTimer;

  final Map<String, dynamic> _iceConfig = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
      {'urls': 'stun:stun2.l.google.com:19302'},
      {
        'urls': [
          'turn:openrelay.metered.ca:80',
          'turn:openrelay.metered.ca:443',
          'turn:openrelay.metered.ca:443?transport=tcp',
        ],
        'username': 'openrelayproject',
        'credential': 'openrelayproject',
      },
      {
        'urls': 'turn:a.relay.metered.ca:443',
        'username': 'openrelayproject',
        'credential': 'openrelayproject',
      },
    ],
    'iceCandidatePoolSize': 10,
    'sdpSemantics': 'unified-plan',
  };

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _pulseCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.92, end: 1.0).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _initCall();
    _resetHideTimer();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pulseCtrl.dispose();
    _fadeCtrl.dispose();
    _timer?.cancel();
    _hideControlsTimer?.cancel();
    _localStream?.getTracks().forEach((t) => t.stop());
    _signaling.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  // ── Initialisation ─────────────────────────────────────────────────────────

  Future<void> _initCall() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    await _openAudio(); // Audio-only by default
    _initSignaling();
  }

  void _initSignaling() {
    _signaling = WebRTCSignalingService();

    _signaling.onRemoteUserJoined = (data) {
      _remoteUserId = data['userId'] as String?;
      _createOffer();
    };

    _signaling.onRemoteUserLeft = (data) {
      if (_remoteUserId == data['userId']) {
        _remoteRenderer.srcObject = null;
        if (mounted) setState(() => _remoteConnected = false);
        _timer?.cancel();
      }
    };

    _signaling.onRoomPeers = (data) {
      final peers = data['peers'] as List<dynamic>? ?? [];
      if (peers.isNotEmpty) {
        _remoteUserId = peers.first['userId'] as String?;
        _createOffer();
      }
    };

    _signaling.onReceiveOffer = (data) async {
      final offer = data['offer'] as Map<String, dynamic>;
      _remoteUserId = data['fromUserId'] as String?;
      await _createAnswer(
          RTCSessionDescription(offer['sdp'] as String, offer['type'] as String));
    };

    _signaling.onReceiveAnswer = (data) async {
      final answer = data['answer'] as Map<String, dynamic>;
      if (_peerConnection != null) {
        await _peerConnection!.setRemoteDescription(
            RTCSessionDescription(answer['sdp'] as String, answer['type'] as String));
        if (mounted) setState(() => _remoteConnected = true);
        _startTimer();
      }
    };

    _signaling.onReceiveIceCandidate = (data) async {
      final cand = data['candidate'] as Map<String, dynamic>;
      await _peerConnection?.addCandidate(RTCIceCandidate(
        cand['candidate'] as String?,
        cand['sdpMid'] as String?,
        cand['sdpMLineIndex'] as int?,
      ));
    };

    _signaling.connect(
        _resolveServerUrl(), widget.appointmentId, widget.currentUserId);
  }

  /// Start with audio-only stream
  Future<void> _openAudio() async {
    try {
      final stream =
          await navigator.mediaDevices.getUserMedia({'audio': true, 'video': false});
      _localRenderer.srcObject = stream;
      _localStream = stream;
      await _createPeerConnection();
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('[Call] getUserMedia audio error: $e');
    }
  }

  /// Enable camera mid-call
  Future<void> _enableCamera() async {
    if (_cameraOn) return;
    try {
      final videoStream = await navigator.mediaDevices
          .getUserMedia({'audio': false, 'video': true});
      final videoTracks = videoStream.getVideoTracks();
      if (videoTracks.isEmpty) {
        debugPrint('[Call] enableCamera: no video tracks returned');
        return;
      }
      final videoTrack = videoTracks.first;

      // Add video track to existing stream and peer connection
      _localStream?.addTrack(videoTrack);
      _localRenderer.srcObject = _localStream;
      if (_peerConnection != null) {
        await _peerConnection!.addTrack(videoTrack, _localStream!);
        // Renegotiate
        if (_remoteUserId != null) await _createOffer();
      }
      if (mounted) setState(() => _cameraOn = true);
    } catch (e) {
      debugPrint('[Call] enableCamera error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Could not access camera: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  /// Turn off camera mid-call
  void _disableCamera() {
    final tracks = _localStream?.getVideoTracks() ?? [];
    for (final t in tracks) {
      t.stop();
      _localStream?.removeTrack(t);
    }
    if (mounted) setState(() => _cameraOn = false);
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection(_iceConfig);

    _peerConnection!.onIceCandidate = (candidate) {
      if (_remoteUserId != null) {
        _signaling.sendIceCandidate(
          widget.appointmentId,
          _remoteUserId!,
          candidate,
          widget.currentUserId,
        );
      }
    };

    _peerConnection!.onIceConnectionState = (state) {
      debugPrint('[WebRTC] ICE: $state');
      if (state == RTCIceConnectionState.RTCIceConnectionStateConnected) {
        if (mounted) setState(() => _remoteConnected = true);
        _startTimer();
      } else if (state == RTCIceConnectionState.RTCIceConnectionStateFailed) {
        _peerConnection?.restartIce();
      }
    };

    _peerConnection!.onTrack = (event) {
      if (event.track.kind == 'audio') {
        if (mounted) setState(() => _remoteConnected = true);
        _startTimer();
      } else if (event.track.kind == 'video' &&
          event.streams.isNotEmpty) {
        _remoteRenderer.srcObject = event.streams[0];
        if (mounted) setState(() {
          _remoteConnected = true;
          _remoteCameraOn = true;
        });
        _startTimer();
      }
    };

    _localStream?.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });
  }

  Future<void> _createOffer() async {
    if (_peerConnection == null || _remoteUserId == null) return;
    final offer = await _peerConnection!.createOffer({
      'offerToReceiveAudio': true,
      'offerToReceiveVideo': true,
    });
    await _peerConnection!.setLocalDescription(offer);
    _signaling.sendOffer(
        widget.appointmentId, _remoteUserId!, offer, widget.currentUserId);
  }

  Future<void> _createAnswer(RTCSessionDescription offer) async {
    if (_peerConnection == null || _remoteUserId == null) return;
    await _peerConnection!.setRemoteDescription(offer);
    final answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);
    _signaling.sendAnswer(
        widget.appointmentId, _remoteUserId!, answer, widget.currentUserId);
    if (mounted) setState(() => _remoteConnected = true);
    _startTimer();
  }

  // ── Controls ───────────────────────────────────────────────────────────────

  void _startTimer() {
    if (_timer?.isActive ?? false) return;
    _timer = Timer.periodic(const Duration(seconds: 1),
        (_) { if (mounted) setState(() => _elapsedSeconds++); });
  }

  void _toggleMic() {
    final tracks = _localStream?.getAudioTracks() ?? [];
    if (tracks.isEmpty) return;
    tracks.first.enabled = !tracks.first.enabled;
    if (mounted) setState(() => _micMuted = !tracks.first.enabled);
  }

  void _toggleSpeaker() {
    // Note: flutter_webrtc speaker toggle
    if (mounted) setState(() => _speakerOn = !_speakerOn);
  }

  void _switchCamera() async {
    final tracks = _localStream?.getVideoTracks() ?? [];
    if (tracks.isNotEmpty) await Helper.switchCamera(tracks.first);
  }

  void _hangUp() {
    _timer?.cancel();
    _signaling.leaveRoom(widget.appointmentId, widget.currentUserId);
    _localStream?.getTracks().forEach((t) => t.stop());
    _peerConnection?.close();
    _signaling.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    if (mounted) Navigator.of(context).pop();
  }

  void _resetHideTimer() {
    _hideControlsTimer?.cancel();
    if (!_showControls) setState(() => _showControls = true);
    if (_cameraOn) {
      _hideControlsTimer = Timer(const Duration(seconds: 4), () {
        if (mounted && _cameraOn) setState(() => _showControls = false);
      });
    }
  }

  String _formatTime(int total) {
    final h = total ~/ 3600;
    final m = ((total % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (total % 60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isVideoMode = _cameraOn && _remoteConnected && _remoteCameraOn;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1E),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Full-screen remote video (video mode only) ─────────────────
          if (isVideoMode && _remoteRenderer.srcObject != null)
            RTCVideoView(
              _remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            )
          else
            // Dark gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0A0F1E), Color(0xFF0D1A2E), Color(0xFF0A1628)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

          // ── UI column (top bar + center + bottom controls) ─────────────
          GestureDetector(
            onTap: isVideoMode ? _resetHideTimer : null,
            child: AnimatedOpacity(
              opacity: isVideoMode && !_showControls ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: SafeArea(
                child: Column(
                  children: [
                    // ── Top bar ─────────────────────────────────────────
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        children: [
                          _IconBtn(
                            icon: Icons.arrow_back_ios_new_rounded,
                            onTap: _hangUp,
                          ),
                          const Spacer(),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            child: _remoteConnected
                                ? _StatusChip(
                                    key: const ValueKey('connected'),
                                    label: _formatTime(_elapsedSeconds),
                                    color: const Color(0xFF10B981),
                                    icon: Icons.circle,
                                  )
                                : _StatusChip(
                                    key: const ValueKey('connecting'),
                                    label: 'Connecting…',
                                    color: const Color(0xFFF59E0B),
                                    icon: Icons.hourglass_top_rounded,
                                  ),
                          ),
                        ],
                      ),
                    ),

                    // ── Centre ─────────────────────────────────────────
                    Expanded(
                      child: isVideoMode
                          ? _buildVideoCenter()
                          : _buildAudioCenter(),
                    ),

                    // ── Bottom controls ─────────────────────────────────
                    _buildControls(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// PiP + tap-to-flip hint when in video mode
  Widget _buildVideoCenter() {
    return Stack(
      children: [
        // Local PiP — top right
        Positioned(
          right: 16.w,
          top: 8.h,
          width: 96.w,
          height: 140.h,
          child: GestureDetector(
            onTap: _switchCamera,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3), width: 1.5),
              ),
              clipBehavior: Clip.hardEdge,
              child: _localStream?.getVideoTracks().isNotEmpty == true
                  ? RTCVideoView(
                      _localRenderer,
                      mirror: true,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    )
                  : Container(
                      color: Colors.black54,
                      child: Icon(Icons.videocam_off_rounded,
                          color: Colors.white60, size: 24.sp),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  /// Avatar + status text when voice-only
  Widget _buildAudioCenter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: _pulseAnim,
          child: Container(
            width: 110.w,
            height: 110.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF0D9488), Color(0xFF14B8A6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0D9488)
                      .withValues(alpha: _remoteConnected ? 0.5 : 0.2),
                  blurRadius: _remoteConnected ? 40 : 20,
                  spreadRadius: _remoteConnected ? 8 : 2,
                ),
              ],
            ),
            child: Icon(Icons.person_rounded, size: 52.sp, color: Colors.white),
          ),
        ),
        SizedBox(height: 24.h),
        if (_remoteConnected) ...[
          Text(
            'Voice Call',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            _formatTime(_elapsedSeconds),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              color: const Color(0xFF10B981),
              fontWeight: FontWeight.w600,
            ),
          ),
        ] else ...[
          Text(
            'Calling…',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Waiting for the other participant',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              color: Colors.white38,
            ),
          ),
        ],
        SizedBox(height: 28.h),
        // Turn on camera button
        _VideoToggleButton(onTap: _enableCamera, label: 'Turn on Camera'),
      ],
    );
  }

  /// Bottom controls bar — always at the bottom of the Column
  Widget _buildControls() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ControlButton(
            icon: _micMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
            label: _micMuted ? 'Unmute' : 'Mute',
            active: !_micMuted,
            onTap: _toggleMic,
          ),
          _ControlButton(
            icon: _cameraOn
                ? Icons.videocam_rounded
                : Icons.videocam_off_rounded,
            label: _cameraOn ? 'Camera' : 'No Video',
            active: _cameraOn,
            onTap: _cameraOn ? _disableCamera : _enableCamera,
          ),
          _EndCallButton(onTap: _hangUp),
          Visibility(
            visible: _cameraOn,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: _ControlButton(
              icon: Icons.flip_camera_ios_rounded,
              label: 'Flip',
              active: true,
              onTap: _switchCamera,
            ),
          ),
          _ControlButton(
            icon: _speakerOn
                ? Icons.volume_up_rounded
                : Icons.volume_off_rounded,
            label: _speakerOn ? 'Speaker' : 'Earpiece',
            active: _speakerOn,
            onTap: _toggleSpeaker,
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────────

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _StatusChip({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withOpacity(0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 8.sp, color: color),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconBtn({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 18.sp),
      ),
    );
  }
}

class _VideoToggleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const _VideoToggleButton({required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: Colors.white.withOpacity(0.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.videocam_rounded, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
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
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52.r,
            height: 52.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? Colors.white.withOpacity(0.15)
                  : Colors.red.withOpacity(0.7),
              border: Border.all(
                color: active ? Colors.white30 : Colors.transparent,
                width: 1,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 22.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.sp,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}

class _EndCallButton extends StatelessWidget {
  final VoidCallback onTap;

  const _EndCallButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.shade600,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.4),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(Icons.call_end_rounded, color: Colors.white, size: 28.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            'End',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.sp,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
