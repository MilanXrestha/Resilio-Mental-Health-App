import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routing/route_names.dart';
import '../../../../../core/widgets/premium_overlay_widget.dart';
import '../../../subscription/presentation/bloc/subscription_bloc.dart';
import '../../../subscription/presentation/bloc/subscription_state.dart';
import '../../../dashboard/domain/entities/quote_entity.dart';
import '../../domain/entities/tip_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';

/// A unified full-page swipeable viewer for Tips and Quotes.
/// Pass either [tips] or [quotes] (not both).
class ContentViewerScreen extends StatefulWidget {
  final List<TipEntity>? tips;
  final List<QuoteEntity>? quotes;
  final int initialIndex;
  final String title;

  const ContentViewerScreen({
    super.key,
    this.tips,
    this.quotes,
    this.initialIndex = 0,
    required this.title,
  }) : assert(tips != null || quotes != null, 'Pass either tips or quotes');

  @override
  State<ContentViewerScreen> createState() => _ContentViewerScreenState();
}

class _ContentViewerScreenState extends State<ContentViewerScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _bgController;

  final FlutterTts _tts = FlutterTts();
  bool _ttsReady = false;
  Future<void>? _ttsInitFuture;
  bool _isSpeaking = false;
  bool _isSlideshowEnabled = false;
  Timer? _slideshowTimer;
  int _countdown = 5;
  int _currentIndex = 0;

  // Viewer controls (mirrors the reference tips_detail_screen behavior).
  bool _isFullScreen = false;
  bool _showSwipeHint = false;

  // Local "settings" — persisted to SharedPreferences.
  int _settingsCountdown = 5;
  bool _settingsShowFullScreenIcon = true;
  bool _settingsShowSwipeIndicator = true;
  bool _settingsSlideshowEnabled = true;

  static const _kCountdown = 'cv_settings_countdown';
  static const _kFullScreen = 'cv_settings_fullscreen';
  static const _kSwipeHint = 'cv_settings_swipe_hint';
  static const _kSlideshow = 'cv_settings_slideshow';

  int get _itemCount =>
      widget.tips?.length ?? widget.quotes?.length ?? 0;

  // ── helpers ───────────────────────────────────────────────────────────────
  String _getTitle(int index) {
    if (widget.tips != null) return widget.tips![index].title;
    return '"${widget.quotes![index].quoteText}"';
  }

  String _getBody(int index) {
    if (widget.tips != null) return widget.tips![index].tipText;
    return '— ${widget.quotes![index].author}';
  }

  String _getAuthor(int index) {
    if (widget.tips != null) return widget.tips![index].author;
    return widget.quotes![index].author;
  }

  String? _getAuthorAvatar(int index) {
    if (widget.tips != null) {
      final url = widget.tips![index].authorIconUrl;
      return url.isNotEmpty ? url : null;
    }
    return widget.quotes![index].authorIconUrl;
  }

  bool get _isQuoteMode => widget.quotes != null;

  bool _isItemPremium(int index) {
    if (widget.tips != null) return widget.tips![index].isPremium;
    if (widget.quotes != null) return widget.quotes![index].isPremium;
    return false;
  }

  // ── gradient palette per index ─────────────────────────────────────────────
  static const List<List<Color>> _gradients = [
    [Color(0xFF6366F1), Color(0xFF4F46E5)],
    [Color(0xFF0D9488), Color(0xFF0F766E)],
    [Color(0xFFF59E0B), Color(0xFFD97706)],
    [Color(0xFFEC4899), Color(0xFFDB2777)],
    [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
    [Color(0xFF10B981), Color(0xFF059669)],
  ];

  List<Color> _gradientForIndex(int index) =>
      _gradients[index % _gradients.length];

  // ── lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadSettings();
      _setupTts();
    });
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _settingsCountdown = prefs.getInt(_kCountdown) ?? 5;
      _settingsShowFullScreenIcon = prefs.getBool(_kFullScreen) ?? true;
      _settingsShowSwipeIndicator = prefs.getBool(_kSwipeHint) ?? true;
      _settingsSlideshowEnabled = prefs.getBool(_kSlideshow) ?? true;
      _countdown = _settingsCountdown;
      _showSwipeHint = _settingsShowSwipeIndicator && _itemCount > 1 && _currentIndex == 0;
    });
    if (_showSwipeHint) {
      Future.delayed(const Duration(seconds: 3)).then((_) {
        if (!mounted) return;
        setState(() => _showSwipeHint = false);
      });
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kCountdown, _settingsCountdown);
    await prefs.setBool(_kFullScreen, _settingsShowFullScreenIcon);
    await prefs.setBool(_kSwipeHint, _settingsShowSwipeIndicator);
    await prefs.setBool(_kSlideshow, _settingsSlideshowEnabled);
  }

  bool _userHasPremiumAccess() {
    final state = context.read<SubscriptionBloc>().state;
    return state is SubscriptionLoaded && state.subscription.isActive;
  }

  bool _ensurePremiumAccessForCurrent() {
    if (!_isItemPremium(_currentIndex)) return true;
    if (_userHasPremiumAccess()) return true;

    context.pushNamed(RouteNames.subscription);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Premium required for this content.')),
    );
    return false;
  }

  Future<void> _setupTts() async {
    if (kIsWeb) {
      if (mounted) setState(() => _ttsReady = false);
      return;
    }
    _ttsInitFuture ??= _configureTts();
    await _ttsInitFuture;
  }

  Future<void> _configureTts() async {
    try {
      await _tts.setLanguage('en-US');
      await _tts.setPitch(1.0);
      await _tts.setSpeechRate(0.48);
      await _tts.setVolume(1.0);
      if (Platform.isIOS) {
        await _tts.setSharedInstance(true);
        await _tts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.playback,
          const [
            IosTextToSpeechAudioCategoryOptions.mixWithOthers,
            IosTextToSpeechAudioCategoryOptions.duckOthers,
            IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
          ],
          IosTextToSpeechAudioMode.spokenAudio,
        );
      }
      _tts.setStartHandler(() {
        if (mounted) {
          setState(() => _isSpeaking = true);
          _pulseController.repeat(reverse: true);
        }
      });
      _tts.setCompletionHandler(() {
        if (mounted) {
          setState(() => _isSpeaking = false);
          _pulseController.stop();
          _pulseController.reset();
        }
      });
      _tts.setErrorHandler((msg) {
        if (mounted) {
          setState(() => _isSpeaking = false);
          _pulseController.stop();
          _pulseController.reset();
          final m = msg?.toString() ?? 'Speech failed';
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(content: Text(m)),
          );
        }
      });
      // Let the Android TTS service finish binding (avoids "not bound to TTS engine").
      if (Platform.isAndroid) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
      }
      if (mounted) setState(() => _ttsReady = true);
    } catch (e, st) {
      debugPrint('TTS setup failed: $e\n$st');
      _ttsInitFuture = null;
      if (mounted) {
        setState(() => _ttsReady = false);
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(content: Text('Could not start text-to-speech: $e')),
        );
      }
    }
  }

  Future<void> _safeTtsStop() async {
    try {
      await _tts.stop();
    } catch (_) {
      /* Engine may reconnect; ignore DeadObject on stop. */
    }
  }

  String _ttsTextForIndex(int index) {
    if (widget.tips != null) {
      final t = widget.tips![index];
      return '${t.title}. ${t.tipText}';
    }
    final q = widget.quotes![index];
    return '${q.quoteText}. By ${q.author}.';
  }

  Future<void> _readAloud() async {
    // Read-aloud is not gated on premium (subscription loading was blocking taps).
    if (kIsWeb) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Read aloud is not available on web.')),
      );
      return;
    }
    final text = _ttsTextForIndex(_currentIndex);
    if (text.trim().isEmpty) return;

    if (_isSpeaking) {
      await _safeTtsStop();
      if (mounted) {
        setState(() => _isSpeaking = false);
        _pulseController.stop();
        _pulseController.reset();
      }
      return;
    }

    await _setupTts();
    if (!_ttsReady) return;

    try {
      await _safeTtsStop();
      if (Platform.isAndroid) {
        await Future<void>.delayed(const Duration(milliseconds: 80));
        await _tts.speak(text, focus: true);
      } else {
        await _tts.speak(text);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(content: Text('Read aloud failed: $e')),
        );
      }
    }
  }

  void _toggleSlideshow() {
    if (!_settingsSlideshowEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Slideshow is disabled in settings')),
      );
      return;
    }
    if (!_ensurePremiumAccessForCurrent()) return;

    setState(() {
      _isSlideshowEnabled = !_isSlideshowEnabled;
      if (_isSlideshowEnabled) {
        if (_currentIndex >= _itemCount - 1) {
          _currentIndex = 0;
          _pageController.jumpToPage(0);
        }
        _isFullScreen = true;
        _countdown = _settingsCountdown;
        _startSlideshow();
      } else {
        _slideshowTimer?.cancel();
        _countdown = _settingsCountdown;
        _isFullScreen = false;
      }
    });

    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
  }

  void _startSlideshow() {
    _slideshowTimer?.cancel();
    _slideshowTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) { t.cancel(); return; }
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          if (_currentIndex < _itemCount - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
            );
            _countdown = _settingsCountdown;
          } else {
            _isSlideshowEnabled = false;
            _isFullScreen = false;
            _countdown = _settingsCountdown;
            t.cancel();
          }
        }
      });
    });
  }

  void _toggleFullScreen() {
    if (!_settingsShowFullScreenIcon) return;
    if (!_ensurePremiumAccessForCurrent()) return;

    setState(() => _isFullScreen = !_isFullScreen);
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pulseController.dispose();
    _bgController.dispose();
    _slideshowTimer?.cancel();
    _tts.stop();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  // ── build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_itemCount == 0) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: const Center(child: Text('No content available')),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // ── Animated background ──────────────────────────────────────
            AnimatedBuilder(
              animation: _bgController,
              builder: (context, _) {
                final colors = _gradientForIndex(_currentIndex);
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: colors,
                    ),
                  ),
                );
              },
            ),

            // Ambient blobs
            _AmbientBlob(colors: _gradientForIndex(_currentIndex)),

            // ── Page view (vertical: swipe up/down for next/previous) ─────
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: _itemCount,
              onPageChanged: (i) {
                setState(() {
                  _currentIndex = i;
                });
                _bgController.forward(from: 0);
                if (_isSpeaking) {
                  _safeTtsStop();
                  setState(() => _isSpeaking = false);
                  _pulseController.stop();
                  _pulseController.reset();
                }
                if (_isSlideshowEnabled) _countdown = _settingsCountdown;
              },
              itemBuilder: (context, index) {
                return _ContentPage(
                  title: _getTitle(index),
                  body: _getBody(index),
                  author: _getAuthor(index),
                  authorAvatar: _getAuthorAvatar(index),
                  isQuote: _isQuoteMode,
                );
              },
            ),

            // ── Premium blur (below chrome so bars stay tappable) ───────
            BlocBuilder<SubscriptionBloc, SubscriptionState>(
              builder: (context, state) {
                // Avoid locking content while subscription status is still loading.
                if (state is SubscriptionLoading || state is SubscriptionInitial) {
                  return const SizedBox.shrink();
                }
                final bool isPremiumUser =
                    state is SubscriptionLoaded && state.subscription.isActive;
                final bool isContentPremium = _isItemPremium(_currentIndex);

                if (isContentPremium && !isPremiumUser) {
                  return PremiumOverlayWidget(
                    onUpgradePressed: () {
                      context.pushNamed(RouteNames.subscription);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // ── Top bar ──────────────────────────────────────────────────
            if (!_isFullScreen)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _TopBar(
                  title: widget.title,
                  current: _currentIndex + 1,
                  total: _itemCount,
                  isSlideshowEnabled: _isSlideshowEnabled,
                  countdown: _countdown,
                  isQuoteMode: _isQuoteMode,
                  quotes: widget.quotes,
                  tips: widget.tips,
                  currentIndex: _currentIndex,
                  onBack: () => Navigator.pop(context),
                  onSettings: _showTimerSettings,
                ),
              ),

            // ── Bottom actions ───────────────────────────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _BottomActions(
                isSpeaking: _isSpeaking,
                isSlideshowEnabled: _isSlideshowEnabled,
                pulseAnimation: _pulseAnimation,
                isQuoteMode: _isQuoteMode,
                quotes: widget.quotes,
                tips: widget.tips,
                currentIndex: _currentIndex,
                onTts: _readAloud,
                onSlideshow: _toggleSlideshow,
                onShare: () => _shareCurrent(),
                showSlideshowButton: _settingsSlideshowEnabled,
                showFullScreenIcon: _settingsShowFullScreenIcon,
                isFullScreen: _isFullScreen,
                onFullScreen: _toggleFullScreen,
              ),
            ),

            // ── Swipe hint ─────────────────────────────────────────────
            if (_showSwipeHint && !_isFullScreen) const _SwipeHint(),
          ],
        ),
      ),
    );
  }

  void _shareCurrent() {
    final text = '${_getTitle(_currentIndex)}\n${_getBody(_currentIndex)}';
    HapticFeedback.lightImpact();
    SharePlus.instance.share(
      ShareParams(text: text, subject: widget.title),
    );
  }

  void _showTimerSettings() {
    int tempCountdown = _settingsCountdown;
    bool tempShowFullScreenIcon = _settingsShowFullScreenIcon;
    bool tempShowSwipeIndicator = _settingsShowSwipeIndicator;
    bool tempSlideshowEnabled = _settingsSlideshowEnabled;

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            final theme = Theme.of(dialogContext);
            final surface = const Color(0xFF1A1A24);
            final onSurface = Colors.white.withValues(alpha: 0.92);

            return Dialog(
              backgroundColor: surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.tune_rounded,
                              color: const Color(0xFF818CF8),
                              size: 22.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Viewer settings',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    color: onSurface,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Slideshow timing and on-screen controls',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontFamily: 'Poppins',
                                    color: onSurface.withValues(alpha: 0.65),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Time per slide',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: onSurface.withValues(alpha: 0.85),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '$tempCountdown seconds',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF818CF8),
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF6366F1),
                          inactiveTrackColor: Colors.white.withValues(alpha: 0.12),
                          thumbColor: const Color(0xFFA5B4FC),
                          overlayColor: const Color(0xFF6366F1).withValues(alpha: 0.2),
                        ),
                        child: Slider(
                          min: 1,
                          max: 10,
                          divisions: 9,
                          value: tempCountdown.toDouble(),
                          onChanged: (v) {
                            setStateDialog(() => tempCountdown = v.round());
                          },
                        ),
                      ),
                      Divider(color: Colors.white.withValues(alpha: 0.08)),
                      _SettingsSwitchTile(
                        icon: Icons.slideshow_rounded,
                        title: 'Slideshow',
                        subtitle: 'Auto-advance slides in fullscreen',
                        value: tempSlideshowEnabled,
                        onChanged: (v) => setStateDialog(() => tempSlideshowEnabled = v),
                      ),
                      SizedBox(height: 8.h),
                      _SettingsSwitchTile(
                        icon: Icons.fullscreen_rounded,
                        title: 'Fullscreen button',
                        subtitle: 'Show in the bottom bar',
                        value: tempShowFullScreenIcon,
                        onChanged: (v) => setStateDialog(() => tempShowFullScreenIcon = v),
                      ),
                      SizedBox(height: 8.h),
                      _SettingsSwitchTile(
                        icon: Icons.swipe_vertical_rounded,
                        title: 'Swipe hint',
                        subtitle: 'Brief tip when multiple items',
                        value: tempShowSwipeIndicator,
                        onChanged: (v) => setStateDialog(() => tempShowSwipeIndicator = v),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: onSurface.withValues(alpha: 0.85),
                                side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  _settingsCountdown = tempCountdown;
                                  _settingsShowFullScreenIcon = tempShowFullScreenIcon;
                                  _settingsShowSwipeIndicator = tempShowSwipeIndicator;
                                  _settingsSlideshowEnabled = tempSlideshowEnabled;
                                  _countdown = tempCountdown;

                                  if (!_settingsSlideshowEnabled) {
                                    _isSlideshowEnabled = false;
                                    _slideshowTimer?.cancel();
                                    _isFullScreen = false;
                                  }
                                  _showSwipeHint = _settingsShowSwipeIndicator &&
                                      _itemCount > 1 &&
                                      _currentIndex == 0 &&
                                      !_isFullScreen;
                                  if (_showSwipeHint) {
                                    Future.delayed(const Duration(seconds: 3)).then((_) {
                                      if (!mounted) return;
                                      setState(() => _showSwipeHint = false);
                                    });
                                  }
                                });
                                _saveSettings();
                                Navigator.pop(dialogContext);
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF6366F1),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final onSurface = Colors.white.withValues(alpha: 0.92);
    return Material(
      color: Colors.white.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(14.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              Icon(icon, size: 22.sp, color: const Color(0xFF94A3B8)),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: onSurface,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.sp,
                        color: onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: value,
                onChanged: onChanged,
                activeTrackColor: const Color(0xFF6366F1).withValues(alpha: 0.55),
                activeThumbColor: const Color(0xFFE0E7FF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AMBIENT BLOBS
// ─────────────────────────────────────────────────────────────────────────────

class _AmbientBlob extends StatelessWidget {
  final List<Color> colors;
  const _AmbientBlob({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -60.h,
          right: -60.w,
          child: Container(
            width: 200.w,
            height: 200.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.06),
            ),
          ),
        ),
        Positioned(
          bottom: 100.h,
          left: -80.w,
          child: Container(
            width: 260.w,
            height: 260.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT PAGE
// ─────────────────────────────────────────────────────────────────────────────

class _ContentPage extends StatelessWidget {
  final String title;
  final String body;
  final String author;
  final String? authorAvatar;
  final bool isQuote;

  const _ContentPage({
    required this.title,
    required this.body,
    required this.author,
    this.authorAvatar,
    required this.isQuote,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 80.h, 24.w, 120.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isQuote)
              Icon(
                Icons.format_quote_rounded,
                size: 48.sp,
                color: Colors.white.withValues(alpha: 0.25),
              )
            else
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Wellness Tip',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

            SizedBox(height: 24.h),

            Text(
              title,
              style: TextStyle(
                fontFamily: isQuote ? 'PlayfairDisplay' : 'Poppins',
                fontSize: isQuote ? 26.sp : 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontStyle: isQuote ? FontStyle.italic : FontStyle.normal,
                height: 1.5,
              ),
            ),

            if (!isQuote && body.isNotEmpty) ...[
              SizedBox(height: 20.h),
              Text(
                body,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.85),
                  height: 1.6,
                ),
              ),
            ],

            SizedBox(height: 32.h),

            if (author.isNotEmpty)
              Row(
                children: [
                  Container(
                    width: 30.w,
                    height: 1.h,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                  SizedBox(width: 12.w),
                  if (authorAvatar != null && authorAvatar!.isNotEmpty) ...[
                    CircleAvatar(
                      radius: 14.r,
                      backgroundImage: NetworkImage(authorAvatar!),
                      onBackgroundImageError: (_, __) {},
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Flexible(
                    child: Text(
                      isQuote ? '— $author' : author,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TOP BAR
// ─────────────────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final String title;
  final int current;
  final int total;
  final bool isSlideshowEnabled;
  final int countdown;
  final bool isQuoteMode;
  final List<QuoteEntity>? quotes;
  final List<TipEntity>? tips;
  final int currentIndex;
  final VoidCallback onBack;
  final VoidCallback onSettings;

  const _TopBar({
    required this.title,
    required this.current,
    required this.total,
    required this.isSlideshowEnabled,
    required this.countdown,
    required this.isQuoteMode,
    this.quotes,
    this.tips,
    required this.currentIndex,
    required this.onBack,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Counter chip
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                isSlideshowEnabled ? '$countdown s' : '$current / $total',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 6.w),
            IconButton(
              onPressed: onSettings,
              icon: Icon(
                Icons.settings_rounded,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM ACTIONS
// ─────────────────────────────────────────────────────────────────────────────

class _BottomActions extends StatelessWidget {
  final bool isSpeaking;
  final bool isSlideshowEnabled;
  final Animation<double> pulseAnimation;
  final bool isQuoteMode;
  final List<QuoteEntity>? quotes;
  final List<TipEntity>? tips;
  final int currentIndex;
  final VoidCallback onTts;
  final VoidCallback onSlideshow;
  final VoidCallback onShare;
  final bool showSlideshowButton;
  final bool showFullScreenIcon;
  final bool isFullScreen;
  final VoidCallback onFullScreen;

  const _BottomActions({
    required this.isSpeaking,
    required this.isSlideshowEnabled,
    required this.pulseAnimation,
    required this.isQuoteMode,
    this.quotes,
    this.tips,
    required this.currentIndex,
    required this.onTts,
    required this.onSlideshow,
    required this.onShare,
    required this.showSlideshowButton,
    required this.showFullScreenIcon,
    required this.isFullScreen,
    required this.onFullScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withOpacity(0.5), Colors.transparent],
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        24.w,
        16.h,
        24.w,
        MediaQuery.of(context).padding.bottom + 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ActionBtn(
            icon: isSpeaking ? Icons.pause_rounded : Icons.volume_up_rounded,
            label: isSpeaking ? 'Pause' : 'Read',
            isActive: isSpeaking,
            animation: isSpeaking ? pulseAnimation : null,
            onTap: onTts,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FavoriteButton(
                contentId: isQuoteMode
                    ? quotes![currentIndex].id
                    : tips![currentIndex].id,
                contentType:
                    isQuoteMode ? FavoriteType.quote : FavoriteType.tip,
                size: 28.sp,
                color: Colors.white,
                padding: EdgeInsets.all(12.r),
                bordered: true,
              ),
              SizedBox(height: 6.h),
              Text(
                'Favorite',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.75),
                ),
              ),
            ],
          ),
          if (showSlideshowButton)
            _ActionBtn(
              icon: isSlideshowEnabled ? Icons.stop_rounded : Icons.slideshow_rounded,
              label: isSlideshowEnabled ? 'Stop' : 'Slideshow',
              isActive: isSlideshowEnabled,
              activeColor: const Color(0xFFF59E0B),
              onTap: onSlideshow,
            ),
          if (showFullScreenIcon)
            _ActionBtn(
              icon: isFullScreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
              label: 'Fullscreen',
              isActive: isFullScreen,
              onTap: onFullScreen,
            ),
          _ActionBtn(
            icon: Icons.share_rounded,
            label: 'Share',
            onTap: onShare,
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  final Color? activeColor;
  final Animation<double>? animation;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.activeColor,
    this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = activeColor ?? const Color(0xFF6366F1);

    Widget btnCore = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: isActive
                ? effectiveColor.withOpacity(0.25)
                : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isActive
                  ? effectiveColor.withOpacity(0.6)
                  : Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Icon(
            icon,
            color: isActive ? effectiveColor : Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );

    if (animation != null) {
      btnCore = ScaleTransition(scale: animation!, child: btnCore);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        btnCore,
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.75),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SWIPE HINT
// ─────────────────────────────────────────────────────────────────────────────

class _SwipeHint extends StatelessWidget {
  const _SwipeHint();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 96.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.keyboard_arrow_up_rounded,
              color: Colors.white.withOpacity(0.85),
              size: 36.sp,
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Text(
                'Swipe up for next',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
