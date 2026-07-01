import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import '../../services/webrtc_signaling_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Resilio/l10n/app_localizations.dart';

class VideoCallScreen extends StatefulWidget {
  final String appointmentId;
  final String currentUserId;
  final String callerName;

  const VideoCallScreen({
    super.key,
    required this.appointmentId,
    required this.currentUserId,
    this.callerName = '',
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
  bool _cameraOn = false;
  bool _remoteCameraOn = false;

  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _hangingUp = false;

  // Controls auto-hide in video mode
  bool _showControls = true;
  Timer? _hideControlsTimer;

  // Pulse animation for avatar ring
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  static const _kBg1 = Color(0xFF0B0D1F);
  static const _kAccent = Color(0xFF5B5FEF);
  static const _kGreen = Color(0xFF22C55E);
  static const _kRed = Color(0xFFEF4444);

  final Map<String, dynamic> _iceConfig = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
      {
        'urls': [
          'turn:openrelay.metered.ca:80',
          'turn:openrelay.metered.ca:443',
          'turn:openrelay.metered.ca:443?transport=tcp',
        ],
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
    _pulseAnim = Tween<double>(begin: 0.88, end: 1.0).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _initCall();
    _resetHideTimer();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pulseCtrl.dispose();
    _timer?.cancel();
    _hideControlsTimer?.cancel();
    _localStream?.getTracks().forEach((t) => t.stop());
    _peerConnection?.close();
    _signaling.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  // ── Init ───────────────────────────────────────────────────────────────────

  Future<void> _initCall() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    await _openAudio();
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
        _timer?.cancel();
        if (mounted) {
          setState(() => _remoteConnected = false);
          Future.delayed(const Duration(milliseconds: 700), _hangUp);
        }
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
      final offer = data['offer'] as Map<dynamic, dynamic>;
      _remoteUserId = data['fromUserId'] as String?;
      await _createAnswer(RTCSessionDescription(
          offer['sdp'] as String, offer['type'] as String));
    };

    _signaling.onReceiveAnswer = (data) async {
      final answer = data['answer'] as Map<dynamic, dynamic>;
      if (_peerConnection != null) {
        await _peerConnection!.setRemoteDescription(RTCSessionDescription(
            answer['sdp'] as String, answer['type'] as String));
        if (mounted) setState(() => _remoteConnected = true);
        _startTimer();
      }
    };

    _signaling.onReceiveIceCandidate = (data) async {
      final cand = data['candidate'] as Map<dynamic, dynamic>;
      await _peerConnection?.addCandidate(RTCIceCandidate(
        cand['candidate'] as String?,
        cand['sdpMid'] as String?,
        cand['sdpMLineIndex'] as int?,
      ));
    };

    _signaling.connect('', widget.appointmentId, widget.currentUserId);
  }

  Future<void> _openAudio() async {
    try {
      final stream = await navigator.mediaDevices
          .getUserMedia({'audio': true, 'video': false});
      _localRenderer.srcObject = stream;
      _localStream = stream;
      await _createPeerConnection();
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('[Call] getUserMedia audio error: $e');
    }
  }

  Future<void> _enableCamera() async {
    if (_cameraOn) return;
    try {
      final videoStream = await navigator.mediaDevices
          .getUserMedia({'audio': false, 'video': true});
      final videoTracks = videoStream.getVideoTracks();
      if (videoTracks.isEmpty) return;
      final videoTrack = videoTracks.first;
      _localStream?.addTrack(videoTrack);
      // Update renderer so local video appears immediately as background
      if (mounted) {
        setState(() {
          _cameraOn = true;
          _localRenderer.srcObject = _localStream;
        });
      }
      if (_peerConnection != null) {
        await _peerConnection!.addTrack(videoTrack, _localStream!);
        if (_remoteUserId != null) await _createOffer();
      }
      _resetHideTimer();
    } catch (e) {
      debugPrint('[Call] enableCamera error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.accCameraUnavailable(e.toString())),
          backgroundColor: _kRed,
        ));
      }
    }
  }

  void _disableCamera() {
    for (final t in _localStream?.getVideoTracks() ?? []) {
      t.stop();
      _localStream?.removeTrack(t);
    }
    if (mounted) setState(() => _cameraOn = false);
    _hideControlsTimer?.cancel();
    if (mounted) setState(() => _showControls = true);
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection(_iceConfig);

    _peerConnection!.onIceCandidate = (candidate) {
      if (_remoteUserId != null) {
        _signaling.sendIceCandidate(
            widget.appointmentId, _remoteUserId!, candidate, widget.currentUserId);
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
      } else if (event.track.kind == 'video' && event.streams.isNotEmpty) {
        _remoteRenderer.srcObject = event.streams[0];
        if (mounted) {
          setState(() {
            _remoteConnected = true;
            _remoteCameraOn = true;
          });
        }
        _startTimer();
      }
    };

    _localStream?.getTracks()
        .forEach((t) => _peerConnection!.addTrack(t, _localStream!));
  }

  Future<void> _createOffer() async {
    if (_peerConnection == null || _remoteUserId == null) return;
    final offer = await _peerConnection!.createOffer(
        {'offerToReceiveAudio': true, 'offerToReceiveVideo': true});
    await _peerConnection!.setLocalDescription(offer);
    _signaling.sendOffer(
        widget.appointmentId, _remoteUserId!, offer, widget.currentUserId);
  }

  Future<void> _createAnswer(RTCSessionDescription offer) async {
    if (_peerConnection == null) return;
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
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _elapsedSeconds++);
    });
  }

  void _toggleMic() {
    final tracks = _localStream?.getAudioTracks() ?? [];
    if (tracks.isEmpty) return;
    tracks.first.enabled = !tracks.first.enabled;
    if (mounted) setState(() => _micMuted = !tracks.first.enabled);
  }

  void _toggleSpeaker() {
    if (mounted) setState(() => _speakerOn = !_speakerOn);
  }

  void _switchCamera() async {
    final tracks = _localStream?.getVideoTracks() ?? [];
    if (tracks.isNotEmpty) await Helper.switchCamera(tracks.first);
  }

  void _hangUp() {
    if (_hangingUp) return;
    _hangingUp = true;
    _timer?.cancel();
    _hideControlsTimer?.cancel();
    _signaling.leaveRoom(widget.appointmentId, widget.currentUserId);
    // Use GoRouter's pop so its route state stays consistent.
    // Navigator.of(context).pop() bypasses GoRouter and can leave the
    // underlying screen (e.g. therapist dashboard) in a black/broken state.
    if (mounted) context.pop();
  }

  void _resetHideTimer() {
    _hideControlsTimer?.cancel();
    if (!_showControls && mounted) setState(() => _showControls = true);
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
    // Show local video as soon as camera is on, regardless of remote state.
    final showLocalVideo =
        _cameraOn && (_localStream?.getVideoTracks().isNotEmpty == true);
    // Show remote video only when the remote peer actually has a video track.
    final showRemoteVideo = _remoteCameraOn &&
        _remoteConnected &&
        _remoteRenderer.srcObject != null;

    final anyVideo = showLocalVideo || showRemoteVideo;

    return Scaffold(
      backgroundColor: _kBg1,
      body: GestureDetector(
        onTap: anyVideo ? _resetHideTimer : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background ─────────────────────────────────────────────
            // Priority: remote video > local video > gradient
            if (showRemoteVideo)
              RTCVideoView(_remoteRenderer,
                  objectFit:
                      RTCVideoViewObjectFit.RTCVideoViewObjectFitCover)
            else if (showLocalVideo)
              RTCVideoView(_localRenderer,
                  mirror: true,
                  objectFit:
                      RTCVideoViewObjectFit.RTCVideoViewObjectFitCover)
            else
              _buildBackground(),

            // ── Gradient overlays (when any video is active) ────────────
            if (anyVideo) ...[
              Positioned(
                top: 0, left: 0, right: 0, height: 160.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.7),
                        Colors.transparent
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0, height: 220.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.85),
                        Colors.transparent
                      ],
                    ),
                  ),
                ),
              ),
            ],

            // ── UI overlay ───────────────────────────────────────────────
            AnimatedOpacity(
              opacity: anyVideo && !_showControls ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: SafeArea(
                child: Column(
                  children: [
                    _buildTopBar(),
                    Expanded(
                      child: Stack(
                        children: [
                          // Audio center: only shown when no local video
                          if (!showLocalVideo)
                            Positioned.fill(child: _buildAudioCenter()),
                          // PiP local preview: only when remote video is
                          // fullscreen and local camera is also on
                          if (showRemoteVideo && showLocalVideo)
                            _buildPiP(),
                        ],
                      ),
                    ),
                    _buildControlBar(showLocalVideo),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_kBg1, Color(0xFF111630), Color(0xFF080A18)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: _hangUp,
            child: Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white70, size: 15.sp),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.callerName.isNotEmpty)
                  Text(
                    widget.callerName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _remoteConnected
                      ? Row(
                          key: const ValueKey('connected'),
                          children: [
                            Container(
                              width: 6.r,
                              height: 6.r,
                              margin: EdgeInsets.only(right: 5.w),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: _kGreen),
                            ),
                            Text(
                              _formatTime(_elapsedSeconds),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                color: _kGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          AppLocalizations.of(context)!.accConnecting,
                          key: const ValueKey('connecting'),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            color: Colors.white38,
                          ),
                        ),
                ),
              ],
            ),
          ),
          Icon(Icons.lock_outline_rounded,
              color: Colors.white24, size: 14.sp),
        ],
      ),
    );
  }

  /// Audio-only center: pulsing avatar + name + status.
  /// The "Turn on Camera" button is only shown when camera is off.
  Widget _buildAudioCenter() {
    final name =
        widget.callerName.isNotEmpty ? widget.callerName : AppLocalizations.of(context)!.accVoiceCall;
    final initial = name[0].toUpperCase();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ── Pulsing ring ──────────────────────────────────────────
        Stack(
          alignment: Alignment.center,
          children: [
            ScaleTransition(
              scale: _pulseAnim,
              child: Container(
                width: 160.r,
                height: 160.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _kAccent.withValues(
                      alpha: _remoteConnected ? 0.15 : 0.08),
                ),
              ),
            ),
            ScaleTransition(
              scale: Tween<double>(begin: 0.94, end: 1.0).animate(
                CurvedAnimation(
                    parent: _pulseCtrl, curve: Curves.easeInOut),
              ),
              child: Container(
                width: 120.r,
                height: 120.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [_kAccent, Color(0xFF818CF8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _kAccent.withValues(
                          alpha: _remoteConnected ? 0.6 : 0.3),
                      blurRadius: _remoteConnected ? 48 : 24,
                      spreadRadius: _remoteConnected ? 8 : 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 44.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 28.h),

        Text(
          name,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 26.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _remoteConnected
              ? Text(
                  _formatTime(_elapsedSeconds),
                  key: const ValueKey('t'),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    color: _kGreen,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  AppLocalizations.of(context)!.accCalling,
                  key: const ValueKey('c'),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    color: Colors.white38,
                  ),
                ),
        ),

        // Only prompt to turn camera on when it is actually off
        if (!_cameraOn) ...[
          SizedBox(height: 36.h),
          _CameraToggleButton(onTap: _enableCamera),
        ],
      ],
    );
  }

  /// PiP local preview — shown in the corner when remote video is fullscreen.
  Widget _buildPiP() {
    return Positioned(
      right: 16.w,
      top: 8.h,
      width: 90.w,
      height: 130.h,
      child: GestureDetector(
        onTap: _switchCamera,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white30, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              RTCVideoView(_localRenderer,
                  mirror: true,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
              Positioned(
                bottom: 4.h,
                right: 4.w,
                child: Icon(Icons.flip_camera_ios_rounded,
                    color: Colors.white60, size: 13.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Control bar — flip button is included/excluded from the list directly
  /// (no Visibility gap hack).
  Widget _buildControlBar(bool showLocalVideo) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(28.r),
              border:
                  Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CtrlBtn(
                  icon: _micMuted
                      ? Icons.mic_off_rounded
                      : Icons.mic_rounded,
                  label: _micMuted ? AppLocalizations.of(context)!.accUnmute : AppLocalizations.of(context)!.accMute,
                  active: !_micMuted,
                  onTap: _toggleMic,
                ),
                _CtrlBtn(
                  icon: _cameraOn
                      ? Icons.videocam_rounded
                      : Icons.videocam_off_rounded,
                  label: _cameraOn ? AppLocalizations.of(context)!.accCamera : AppLocalizations.of(context)!.accNoVideo,
                  active: _cameraOn,
                  onTap: _cameraOn ? _disableCamera : _enableCamera,
                ),
                // ── End call (larger, red) ─────────────────────────
                GestureDetector(
                  onTap: _hangUp,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 62.r,
                        height: 62.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _kRed,
                          boxShadow: [
                            BoxShadow(
                              color: _kRed.withValues(alpha: 0.45),
                              blurRadius: 18,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(Icons.call_end_rounded,
                            color: Colors.white, size: 26.sp),
                      ),
                      SizedBox(height: 6.h),
                      Text(AppLocalizations.of(context)!.accEnd,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.sp,
                              color: Colors.white54)),
                    ],
                  ),
                ),
                // Flip only shown when camera is on — no gap otherwise
                if (showLocalVideo)
                  _CtrlBtn(
                    icon: Icons.flip_camera_ios_rounded,
                    label: AppLocalizations.of(context)!.accFlip,
                    active: true,
                    onTap: _switchCamera,
                  ),
                _CtrlBtn(
                  icon: _speakerOn
                      ? Icons.volume_up_rounded
                      : Icons.volume_off_rounded,
                  label: _speakerOn ? AppLocalizations.of(context)!.accSpeaker : AppLocalizations.of(context)!.accEar,
                  active: _speakerOn,
                  onTap: _toggleSpeaker,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────────

class _CtrlBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const _CtrlBtn({
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
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? Colors.white.withValues(alpha: 0.13)
                  : const Color(0xFFEF4444).withValues(alpha: 0.75),
              border: Border.all(
                color: active
                    ? Colors.white.withValues(alpha: 0.18)
                    : Colors.transparent,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 22.sp),
          ),
          SizedBox(height: 5.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 9.sp,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraToggleButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CameraToggleButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.videocam_rounded, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'Turn on Camera',
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
