import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/features/customer/games/game_hub/data/services/game_service.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

enum BreathPhase { inhale, holdIn, exhale, holdOut, paused, completed }

class BreathingPattern {
  final String name;
  final String description;
  final String icon;
  final int inhale;
  final int holdIn;
  final int exhale;
  final int holdOut;
  final Color color;

  const BreathingPattern({
    required this.name,
    required this.description,
    required this.icon,
    required this.inhale,
    required this.holdIn,
    required this.exhale,
    required this.holdOut,
    required this.color,
  });

  int get cycleDuration => inhale + holdIn + exhale + holdOut;
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class BreathingGameScreen extends StatefulWidget {
  final String userId;
  final String gameId;
  final Map<String, dynamic> gameConfig;

  const BreathingGameScreen({
    Key? key,
    required this.userId,
    required this.gameId,
    required this.gameConfig,
  }) : super(key: key);

  @override
  BreathingGameScreenState createState() => BreathingGameScreenState();
}

class BreathingGameScreenState extends State<BreathingGameScreen>
    with TickerProviderStateMixin {

  static const _patterns = [
    BreathingPattern(
      name: 'Box Breathing',
      description: 'Used by Navy SEALs for stress control.',
      icon: '□',
      inhale: 4, holdIn: 4, exhale: 4, holdOut: 4,
      color: Color(0xFF3B82F6),
    ),
    BreathingPattern(
      name: '4-7-8 Technique',
      description: 'Promotes deep sleep and calms anxiety.',
      icon: '🌙',
      inhale: 4, holdIn: 7, exhale: 8, holdOut: 0,
      color: Color(0xFF8B5CF6),
    ),
    BreathingPattern(
      name: 'Calm Breathing',
      description: 'Simple & gentle rhythm for relaxation.',
      icon: '🌊',
      inhale: 4, holdIn: 2, exhale: 6, holdOut: 0,
      color: Color(0xFF0D9488),
    ),
    BreathingPattern(
      name: 'Energize',
      description: 'Equal rhythm to boost focus & energy.',
      icon: '⚡',
      inhale: 5, holdIn: 0, exhale: 5, holdOut: 0,
      color: Color(0xFFF59E0B),
    ),
  ];

  // Controllers
  late AnimationController _breathAnimController;
  late AnimationController _bgAnimController;
  late Animation<double> _breathAnimation;

  Timer? _countdownTimer;
  Timer? _sessionTimer;
  Timer? _phaseTimer;

  // State flags
  bool _showInstructions = true;
  bool _showPatternSelection = false;
  bool _showCountdown = false;
  bool _gameActive = false;
  bool _showCompletion = false;
  bool _isPaused = false;

  // Game state
  BreathPhase _currentPhase = BreathPhase.paused;
  int _completedRounds = 0;
  int _totalRounds = 5;
  int _score = 0;
  int _countdownValue = 3;
  int _phaseSecondsLeft = 0;
  DateTime? _sessionStartTime;

  BreathingPattern _selectedPattern = _patterns[0];

  // Audio / TTS
  final GameService _gameService = GameService();
  final AudioPlayer _bgPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();
  final FlutterTts _tts = FlutterTts();
  bool _isMusicMuted = false;
  bool _isSfxMuted = false;
  bool _isAudioReady = false;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _totalRounds = (widget.gameConfig['totalRounds'] as int?) ?? 5;

    _breathAnimController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _selectedPattern.inhale),
    );
    _breathAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _breathAnimController, curve: Curves.easeInOut),
    );

    _bgAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _initTts();
    _initAudio();
  }

  @override
  void dispose() {
    _breathAnimController.dispose();
    _bgAnimController.dispose();
    _countdownTimer?.cancel();
    _sessionTimer?.cancel();
    _phaseTimer?.cancel();
    _bgPlayer.dispose();
    _sfxPlayer.dispose();
    _tts.stop();
    super.dispose();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
  }

  Future<void> _initAudio() async {
    try {
      await _bgPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgPlayer.setVolume(0.3);
      await _bgPlayer.play(AssetSource('audio/rain_sound.mp3'));
      _isAudioReady = true;
    } catch (_) {}
  }

  void _speak(String text) {
    if (!_isSfxMuted) _tts.speak(text);
  }

  Future<void> _playSfx(String file) async {
    if (_isSfxMuted || !_isAudioReady) return;
    try {
      await _sfxPlayer.play(AssetSource(file));
    } catch (_) {}
  }

  void _vibrate({bool heavy = false}) {
    if (heavy) {
      HapticFeedback.heavyImpact();
    } else {
      HapticFeedback.mediumImpact();
    }
  }

  // ── Flow ───────────────────────────────────────────────────────────────────

  void _goToPatternSelection() =>
      setState(() { _showInstructions = false; _showPatternSelection = true; });

  void _startWithPattern(BreathingPattern pattern, int rounds) {
    setState(() {
      _selectedPattern = pattern;
      _totalRounds = rounds;
      _showPatternSelection = false;
    });
    _breathAnimController.duration = Duration(seconds: pattern.inhale);
    _startCountdown();
  }

  /// ✅ FIX: Simple Timer.periodic countdown — zero TTS dependency.
  /// The old code gated progression on TTS completion via _waitingForVoice,
  /// which never fired for counts 3→2→1 because _proceedAfterVoice only
  /// handled _countdownValue <= 0. This replaces that entirely.
  void _startCountdown() {
    setState(() { _showCountdown = true; _countdownValue = 3; });
    _speak('3');
    _vibrate();

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) { timer.cancel(); return; }
      final next = _countdownValue - 1;
      setState(() => _countdownValue = next);

      if (next > 0) {
        _speak(next.toString());
        _vibrate();
      } else {
        timer.cancel();
        _speak('Go');
        _vibrate(heavy: true);
        Future.delayed(const Duration(milliseconds: 700), () {
          if (!mounted) return;
          setState(() {
            _showCountdown = false;
            _gameActive = true;
            _score = 0;
            _completedRounds = 0;
            _isPaused = false;
            _sessionStartTime = DateTime.now();
          });
          _startBreathingCycle();
          _startSessionTimer();
        });
      }
    });
  }

  void _startSessionTimer() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted || _isPaused || _currentPhase == BreathPhase.completed) {
        if (_currentPhase == BreathPhase.completed) t.cancel();
        return;
      }
    });
  }

  void _startBreathingCycle() => _transitionTo(BreathPhase.inhale);

  void _transitionTo(BreathPhase phase) {
    if (!mounted || _currentPhase == BreathPhase.completed) return;
    _phaseTimer?.cancel();

    final secs = _phaseDuration(phase);
    setState(() { _currentPhase = phase; _phaseSecondsLeft = secs; });

    // Countdown within the phase
    _phaseTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted || _isPaused) return;
      if (_phaseSecondsLeft > 1) {
        setState(() => _phaseSecondsLeft--);
      } else {
        t.cancel();
      }
    });

    // Animate + speak
    switch (phase) {
      case BreathPhase.inhale:
        _speak('Inhale');
        _playSfx('audio/bell_ting.mp3');
        _breathAnimController.duration = Duration(seconds: _selectedPattern.inhale);
        _breathAnimController.forward(from: 0.0);
        break;
      case BreathPhase.holdIn:
        _speak('Hold');
        _breathAnimController.stop();
        break;
      case BreathPhase.exhale:
        _speak('Exhale');
        _playSfx('audio/bell_ting_low.mp3');
        _breathAnimController.duration = Duration(seconds: _selectedPattern.exhale);
        _breathAnimController.reverse(from: 1.0);
        break;
      case BreathPhase.holdOut:
        _speak('Hold');
        _breathAnimController.stop();
        break;
      default:
        break;
    }

    // Schedule next phase
    if (secs > 0) {
      Future.delayed(Duration(seconds: secs), () {
        if (!mounted || _isPaused || _currentPhase == BreathPhase.completed) return;
        _nextPhase(phase);
      });
    }
  }

  int _phaseDuration(BreathPhase p) {
    switch (p) {
      case BreathPhase.inhale:  return _selectedPattern.inhale;
      case BreathPhase.holdIn:  return _selectedPattern.holdIn;
      case BreathPhase.exhale:  return _selectedPattern.exhale;
      case BreathPhase.holdOut: return _selectedPattern.holdOut;
      default: return 0;
    }
  }

  void _nextPhase(BreathPhase current) {
    switch (current) {
      case BreathPhase.inhale:
        _selectedPattern.holdIn > 0
            ? _transitionTo(BreathPhase.holdIn)
            : _transitionTo(BreathPhase.exhale);
        break;
      case BreathPhase.holdIn:
        _transitionTo(BreathPhase.exhale);
        break;
      case BreathPhase.exhale:
        _selectedPattern.holdOut > 0
            ? _transitionTo(BreathPhase.holdOut)
            : _finishRound();
        break;
      case BreathPhase.holdOut:
        _finishRound();
        break;
      default:
        break;
    }
  }

  void _finishRound() {
    if (!mounted) return;
    _vibrate();
    setState(() {
      _completedRounds++;
      _score += 10 + (_completedRounds * 2);
    });
    if (_completedRounds >= _totalRounds) {
      _completeSession();
    } else {
      _transitionTo(BreathPhase.inhale);
    }
  }

  void _togglePause() {
    setState(() => _isPaused = !_isPaused);
    if (_isPaused) {
      _breathAnimController.stop();
      _bgPlayer.pause();
    } else {
      _bgPlayer.resume();
      if (_currentPhase == BreathPhase.inhale) _breathAnimController.forward();
      if (_currentPhase == BreathPhase.exhale) _breathAnimController.reverse();
      // Re-schedule remaining phase time
      final remaining = _phaseSecondsLeft;
      if (remaining > 0) {
        Future.delayed(Duration(seconds: remaining), () {
          if (!mounted || _isPaused || _currentPhase == BreathPhase.completed) return;
          _nextPhase(_currentPhase);
        });
      }
    }
  }

  void _completeSession() {
    _phaseTimer?.cancel();
    _sessionTimer?.cancel();
    _breathAnimController.stop();
    _bgPlayer.stop();

    setState(() {
      _gameActive = false;
      _currentPhase = BreathPhase.completed;
      _showCompletion = true;
    });

    _playSfx('audio/success_chime.mp3');
    _vibrate(heavy: true);

    final dur = _sessionStartTime != null
        ? DateTime.now().difference(_sessionStartTime!)
        : Duration(seconds: _selectedPattern.cycleDuration * _completedRounds);

    _gameService.saveGameSession(
      userId: widget.userId,
      gameId: widget.gameId,
      score: _score,
      streak: _completedRounds,
      duration: dur,
      sessionData: {
        'pattern': _selectedPattern.name,
        'totalRounds': _totalRounds,
        'completedRounds': _completedRounds,
      },
    );
  }

  // ── Derived UI state ────────────────────────────────────────────────────────

  Color get _phaseColor {
    switch (_currentPhase) {
      case BreathPhase.inhale:  return const Color(0xFF3B82F6);
      case BreathPhase.holdIn:  return const Color(0xFF8B5CF6);
      case BreathPhase.exhale:  return const Color(0xFF10B981);
      case BreathPhase.holdOut: return const Color(0xFFF59E0B);
      default: return _selectedPattern.color;
    }
  }

  String get _phaseLabel {
    switch (_currentPhase) {
      case BreathPhase.inhale:  return 'Breathe In';
      case BreathPhase.holdIn:  return 'Hold';
      case BreathPhase.exhale:  return 'Breathe Out';
      case BreathPhase.holdOut: return 'Hold';
      case BreathPhase.paused:  return 'Ready';
      case BreathPhase.completed: return 'Done';
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      body: AnimatedBuilder(
        animation: _bgAnimController,
        builder: (context, child) {
          final c = _gameActive ? _phaseColor : _selectedPattern.color;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(const Color(0xFF080818), c,
                      0.18 + _bgAnimController.value * 0.06)!,
                  Color.lerp(const Color(0xFF0D0D1A), c,
                      0.08 + _bgAnimController.value * 0.03)!,
                ],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(child: _buildCurrentView()),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white70),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Mindful Breathing',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      actions: [
        if (_gameActive) ...[
          IconButton(
            icon: Icon(
              _isMusicMuted ? Icons.music_off : Icons.music_note,
              color: Colors.white60,
              size: 20.sp,
            ),
            onPressed: () {
              setState(() => _isMusicMuted = !_isMusicMuted);
              if (_isMusicMuted) _bgPlayer.pause(); else _bgPlayer.resume();
            },
          ),
          IconButton(
            icon: Icon(
              _isSfxMuted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white60,
              size: 20.sp,
            ),
            onPressed: () => setState(() => _isSfxMuted = !_isSfxMuted),
          ),
        ],
      ],
    );
  }

  Widget _buildCurrentView() {
    if (_showCompletion)       return _buildCompletion();
    if (_showCountdown)        return _buildCountdown();
    if (_showPatternSelection) return _buildPatternSelection();
    if (_gameActive)           return _buildGame();
    return _buildInstructions();
  }

  // ── Instructions ───────────────────────────────────────────────────────────

  Widget _buildInstructions() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(colors: [
                _selectedPattern.color.withOpacity(0.9),
                _selectedPattern.color.withOpacity(0.3),
              ]),
              boxShadow: [
                BoxShadow(
                  color: _selectedPattern.color.withOpacity(0.5),
                  blurRadius: 40, spreadRadius: 5,
                ),
              ],
            ),
            child: Center(child: Text('🫁', style: TextStyle(fontSize: 52.sp))),
          ),
          SizedBox(height: 32.h),
          Text('Mindful Breathing',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 28.sp,
              fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 12.h),
          Text(
            'Reduce stress, improve focus, and find calm through guided breathing.',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp,
              color: Colors.white70, height: 1.5),
          ),
          SizedBox(height: 36.h),
          _featureRow(Icons.psychology_rounded, 'Reduces cortisol & stress levels'),
          SizedBox(height: 10.h),
          _featureRow(Icons.favorite_rounded, 'Lowers heart rate naturally'),
          SizedBox(height: 10.h),
          _featureRow(Icons.bolt_rounded, 'Sharpens mental focus'),
          SizedBox(height: 40.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _goToPatternSelection,
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedPattern.color,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
                elevation: 10,
                shadowColor: _selectedPattern.color.withOpacity(0.6),
              ),
              child: Text('Choose Pattern & Begin',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp,
                  fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureRow(IconData icon, String text) {
    return Row(children: [
      Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: _selectedPattern.color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: _selectedPattern.color, size: 18.sp),
      ),
      SizedBox(width: 12.w),
      Text(text, style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp,
        color: Colors.white70)),
    ]);
  }

  // ── Pattern Selection ──────────────────────────────────────────────────────

  Widget _buildPatternSelection() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose Your Pattern',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 24.sp,
              fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 4.h),
          Text('Different patterns for different needs',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp,
              color: Colors.white60)),
          SizedBox(height: 20.h),
          ..._patterns.map(_patternCard),
          SizedBox(height: 24.h),
          Text('How many rounds?',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp,
              fontWeight: FontWeight.w600, color: Colors.white)),
          SizedBox(height: 12.h),
          Row(
            children: [5, 8, 12, 20].map((r) {
              final sel = _totalRounds == r;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _totalRounds = r),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: sel
                          ? _selectedPattern.color
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text('$r',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp,
                        fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _startWithPattern(_selectedPattern, _totalRounds),
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedPattern.color,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
                elevation: 10,
                shadowColor: _selectedPattern.color.withOpacity(0.6),
              ),
              child: Text('Start $_totalRounds Rounds  →',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp,
                  fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _patternCard(BreathingPattern pattern) {
    final sel = _selectedPattern.name == pattern.name;
    return GestureDetector(
      onTap: () => setState(() => _selectedPattern = pattern),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: sel
              ? pattern.color.withOpacity(0.2)
              : Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: sel ? pattern.color : Colors.transparent, width: 2),
        ),
        child: Row(
          children: [
            Container(
              width: 50.w, height: 50.w,
              decoration: BoxDecoration(
                color: pattern.color.withOpacity(0.2), shape: BoxShape.circle),
              child: Center(child: Text(pattern.icon,
                style: TextStyle(fontSize: 22.sp))),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pattern.name,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp,
                      fontWeight: FontWeight.w600, color: Colors.white)),
                  Text(pattern.description,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp,
                      color: Colors.white60)),
                  SizedBox(height: 6.h),
                  Wrap(spacing: 4.w, children: [
                    _chip('IN ${pattern.inhale}s', const Color(0xFF3B82F6)),
                    if (pattern.holdIn > 0)
                      _chip('HOLD ${pattern.holdIn}s', const Color(0xFF8B5CF6)),
                    _chip('OUT ${pattern.exhale}s', const Color(0xFF10B981)),
                    if (pattern.holdOut > 0)
                      _chip('HOLD ${pattern.holdOut}s', const Color(0xFFF59E0B)),
                  ]),
                ],
              ),
            ),
            if (sel)
              Icon(Icons.check_circle_rounded,
                color: pattern.color, size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(label, style: TextStyle(
        fontFamily: 'Poppins', fontSize: 9.sp,
        fontWeight: FontWeight.w700, color: color)),
    );
  }

  // ── Countdown ─────────────────────────────────────────────────────────────

  Widget _buildCountdown() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Get Ready',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 22.sp,
              color: Colors.white70)),
          SizedBox(height: 32.h),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, anim) => ScaleTransition(
              scale: anim,
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: Text(
              _countdownValue > 0 ? '$_countdownValue' : 'Go!',
              key: ValueKey(_countdownValue),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 100.sp,
                fontWeight: FontWeight.bold,
                color: _selectedPattern.color,
                shadows: [
                  Shadow(color: _selectedPattern.color.withOpacity(0.6),
                    blurRadius: 40),
                ],
              ),
            ),
          ),
          SizedBox(height: 32.h),
          Text(_selectedPattern.name,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp,
              fontWeight: FontWeight.w600, color: Colors.white)),
          Text('$_totalRounds rounds',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp,
              color: Colors.white60)),
        ],
      ),
    );
  }

  // ── Game ──────────────────────────────────────────────────────────────────

  Widget _buildGame() {
    return Column(
      children: [
        // Header bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Round ${_completedRounds + 1} / $_totalRounds',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp,
                      fontWeight: FontWeight.w600, color: Colors.white)),
                  Text(_selectedPattern.name,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp,
                      color: Colors.white60)),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(children: [
                  Icon(Icons.star_rounded, color: Colors.amber, size: 18.sp),
                  SizedBox(width: 4.w),
                  Text('$_score',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp,
                      fontWeight: FontWeight.w700, color: Colors.white)),
                ]),
              ),
            ],
          ),
        ),

        // Progress bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: _completedRounds / _totalRounds,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation(_selectedPattern.color),
              minHeight: 4.h,
            ),
          ),
        ),

        // Breathing circle
        Expanded(child: Center(child: _buildBreathingCircle())),

        // Controls
        _buildControls(),
        SizedBox(height: 32.h),
      ],
    );
  }

  Widget _buildBreathingCircle() {
    return AnimatedBuilder(
      animation: _breathAnimation,
      builder: (context, _) {
        final scale = 0.55 + _breathAnimation.value * 0.45;
        final size = 220.w * scale;
        final color = _phaseColor;

        return Stack(
          alignment: Alignment.center,
          children: [
            // Glow rings
            for (int i = 3; i >= 1; i--)
              Container(
                width: size + i * 28.w,
                height: size + i * 28.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.035 * i),
                ),
              ),
            // Main circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.lerp(color, Colors.white, 0.25)!,
                    color,
                    color.withOpacity(0.55),
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.55),
                    blurRadius: 40 + _breathAnimation.value * 25,
                    spreadRadius: 8 + _breathAnimation.value * 14,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _isPaused ? 'Paused' : _phaseLabel,
                      key: ValueKey(_isPaused ? 'p' : _currentPhase.name),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        shadows: const [
                          Shadow(color: Colors.black26, blurRadius: 8)
                        ],
                      ),
                    ),
                  ),
                  if (_phaseSecondsLeft > 0 && !_isPaused)
                    Text('$_phaseSecondsLeft',
                      style: TextStyle(
                        fontFamily: 'Poppins', fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9))),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildControls() {
    final phases = <_PhaseInfo>[
      _PhaseInfo('In', _selectedPattern.inhale, const Color(0xFF3B82F6), BreathPhase.inhale),
      if (_selectedPattern.holdIn > 0)
        _PhaseInfo('Hold', _selectedPattern.holdIn, const Color(0xFF8B5CF6), BreathPhase.holdIn),
      _PhaseInfo('Out', _selectedPattern.exhale, const Color(0xFF10B981), BreathPhase.exhale),
      if (_selectedPattern.holdOut > 0)
        _PhaseInfo('Hold', _selectedPattern.holdOut, const Color(0xFFF59E0B), BreathPhase.holdOut),
    ];

    return Column(children: [
      Wrap(
        spacing: 8.w,
        children: phases.map((p) {
          final active = _currentPhase == p.phase && !_isPaused;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: active ? p.color.withOpacity(0.3) : Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: active ? p.color : Colors.transparent, width: 1.5),
            ),
            child: Text('${p.label} ${p.secs}s',
              style: TextStyle(
                fontFamily: 'Poppins', fontSize: 12.sp,
                fontWeight: active ? FontWeight.w700 : FontWeight.normal,
                color: active ? p.color : Colors.white54)),
          );
        }).toList(),
      ),
      SizedBox(height: 20.h),
      GestureDetector(
        onTap: _togglePause,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 64.w, height: 64.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.12),
            border: Border.all(color: Colors.white30, width: 2),
          ),
          child: Icon(
            _isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
            color: Colors.white, size: 32.sp),
        ),
      ),
    ]);
  }

  // ── Completion ────────────────────────────────────────────────────────────

  Widget _buildCompletion() {
    final xp = _score + (_completedRounds * 5);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w, height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.amber.shade300, Colors.amber.shade700]),
                boxShadow: [BoxShadow(
                  color: Colors.amber.withOpacity(0.5), blurRadius: 30, spreadRadius: 5)],
              ),
              child: Center(child: Text('🏆', style: TextStyle(fontSize: 52.sp))),
            ),
            SizedBox(height: 24.h),
            Text('Session Complete!',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 28.sp,
                fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 8.h),
            Text('Excellent mindfulness work today.',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp,
                color: Colors.white60)),
            SizedBox(height: 32.h),
            Row(children: [
              Expanded(child: _statBox('Rounds', '$_completedRounds',
                Icons.loop_rounded, Colors.blue)),
              SizedBox(width: 12.w),
              Expanded(child: _statBox('Points', '$_score',
                Icons.stars_rounded, Colors.amber)),
              SizedBox(width: 12.w),
              Expanded(child: _statBox('XP', '+$xp',
                Icons.bolt_rounded, Colors.purple)),
            ]),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: _selectedPattern.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: _selectedPattern.color.withOpacity(0.5)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_selectedPattern.icon, style: TextStyle(fontSize: 20.sp)),
                  SizedBox(width: 8.w),
                  Text(_selectedPattern.name,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp,
                      fontWeight: FontWeight.w600, color: _selectedPattern.color)),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _showCompletion = false;
                      _showInstructions = true;
                      _completedRounds = 0;
                      _score = 0;
                      _currentPhase = BreathPhase.paused;
                    });
                    _initAudio();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white30),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text('Play Again',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedPattern.color,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                    elevation: 8,
                    shadowColor: _selectedPattern.color.withOpacity(0.5),
                  ),
                  child: Text('Done',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp,
                      fontWeight: FontWeight.w600)),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _statBox(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(children: [
        Icon(icon, color: color, size: 22.sp),
        SizedBox(height: 8.h),
        Text(value,
          style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp,
            fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label,
          style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp,
            color: Colors.white54)),
      ]),
    );
  }
}

class _PhaseInfo {
  final String label;
  final int secs;
  final Color color;
  final BreathPhase phase;
  const _PhaseInfo(this.label, this.secs, this.color, this.phase);
}
