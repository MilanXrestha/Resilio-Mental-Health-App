import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/features/customer/games/game_hub/data/services/game_service.dart';
import 'package:Resilio/features/customer/games/mood_tracker/data/models/mood_entry_model.dart';
import 'package:Resilio/features/customer/games/mood_tracker/presentation/screens/mood_calendar_screen.dart';

class MoodTrackerWidget extends StatefulWidget {
  final String userId;

  const MoodTrackerWidget({super.key, required this.userId});

  @override
  _MoodTrackerWidgetState createState() => _MoodTrackerWidgetState();
}

class _MoodTrackerWidgetState extends State<MoodTrackerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  final GameService _gameService = GameService();
  final TextEditingController _journalController = TextEditingController();
  final FocusNode _journalFocus = FocusNode();

  int? _selectedMoodIndex;
  int _intensity = 3; // 1–5
  bool _isSubmitting = false;
  bool _isLoading = true;
  bool _savedToday = false;
  MoodEntryModel? _todayEntry;
  bool _isEditing = false;
  int _streakDays = 0;

  // 8 moods: emoji, label, score, color, prompt
  static const _moods = [
    {'emoji': '😄', 'label': 'Joyful',   'score': 5, 'color': Color(0xFFFBBF24)},
    {'emoji': '😊', 'label': 'Happy',    'score': 4, 'color': Color(0xFF34D399)},
    {'emoji': '😌', 'label': 'Calm',     'score': 4, 'color': Color(0xFF60A5FA)},
    {'emoji': '😐', 'label': 'Neutral',  'score': 3, 'color': Color(0xFF94A3B8)},
    {'emoji': '😔', 'label': 'Sad',      'score': 2, 'color': Color(0xFF818CF8)},
    {'emoji': '😰', 'label': 'Anxious',  'score': 2, 'color': Color(0xFFF97316)},
    {'emoji': '😡', 'label': 'Angry',    'score': 1, 'color': Color(0xFFEF4444)},
    {'emoji': '😴', 'label': 'Tired',    'score': 2, 'color': Color(0xFF8B5CF6)},
  ];

  static const _journalPrompts = [
    "What's on your mind right now?",
    'What made you feel this way?',
    'What are you grateful for today?',
    'What would make today better?',
    'How did you take care of yourself today?',
  ];
  int _promptIndex = 0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _loadTodayData();
  }

  @override
  void dispose() {
    _animController.dispose();
    _journalController.dispose();
    _journalFocus.dispose();
    super.dispose();
  }

  static String get _todayStr =>
      DateTime.now().toIso8601String().split('T').first;

  void _applyTodayEntry(MoodEntryModel? todayEntry, int streak) {
    _streakDays = streak;
    _todayEntry = todayEntry;
    _savedToday = todayEntry != null;
    if (todayEntry != null) {
      var moodIdx = _moods.indexWhere((m) =>
          m['label'] == todayEntry.moodLabel || m['emoji'] == todayEntry.moodLabel);
      if (moodIdx < 0) {
        moodIdx = _moods.indexWhere((m) => m['score'] == todayEntry.moodScore);
      }
      _selectedMoodIndex = moodIdx >= 0 ? moodIdx : null;
      _intensity = todayEntry.moodScore.clamp(1, 5);
      _journalController.text = todayEntry.note;
    }
  }

  Future<void> _writeTodayCache(MoodEntryModel? e, int streak) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mood_today_date', _todayStr);
    await prefs.setInt('mood_streak', streak);
    await prefs.setBool('mood_today_has', e != null);
    if (e != null) {
      await prefs.setString('mood_today_id', e.id);
      await prefs.setInt('mood_today_score', e.moodScore);
      await prefs.setString('mood_today_label', e.moodLabel);
      await prefs.setString('mood_today_note', e.note);
    }
  }

  /// Shows cached today-state instantly (no skeleton), then refreshes silently.
  Future<void> _loadTodayData({bool silent = false}) async {
    // 1. Instant paint from cache when it's for today.
    final prefs = await SharedPreferences.getInstance();
    final cacheIsToday = prefs.getString('mood_today_date') == _todayStr;
    if (cacheIsToday) {
      final has = prefs.getBool('mood_today_has') ?? false;
      final cached = has
          ? MoodEntryModel(
              id: prefs.getString('mood_today_id') ?? '',
              userId: widget.userId,
              moodScore: prefs.getInt('mood_today_score') ?? 3,
              moodLabel: prefs.getString('mood_today_label') ?? '',
              note: prefs.getString('mood_today_note') ?? '',
              entryDate: _todayStr,
              createdAt: DateTime.now(),
            )
          : null;
      if (mounted) {
        setState(() {
          _applyTodayEntry(cached, prefs.getInt('mood_streak') ?? 0);
          _isLoading = false;
        });
      }
    } else if (!silent) {
      setState(() => _isLoading = true);
    }

    // 2. Refresh from server + re-cache.
    try {
      final stats = await _gameService.getUserMoodStats(widget.userId);
      final entries =
          await _gameService.getUserMoodEntries(widget.userId, limit: 100);

      final todayKey = _todayStr;
      final todayMatches = entries.where((e) {
        final d = DateTime.tryParse(e.entryDate);
        final k = d != null
            ? d.toIso8601String().split('T').first
            : e.createdAt.toIso8601String().split('T').first;
        return k == todayKey;
      }).toList();
      final todayEntry = todayMatches.isNotEmpty ? todayMatches.first : null;
      final streak = (stats['currentStreak'] as int?) ?? 0;

      await _writeTodayCache(todayEntry, streak);
      if (mounted) {
        setState(() {
          _applyTodayEntry(todayEntry, streak);
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    if (_selectedMoodIndex == null) return;
    setState(() => _isSubmitting = true);
    HapticFeedback.mediumImpact();

    final mood = _moods[_selectedMoodIndex!];
    final label = mood['label'] as String;
    final note = _journalController.text.trim();
    final score = (_intensity + (mood['score'] as int)) ~/ 2;

    // Snapshot for rollback if the server call fails.
    final prevEntry = _todayEntry;
    final prevSaved = _savedToday;
    final prevStreak = _streakDays;
    final wasFirstEntryToday = !_savedToday;

    // ── Optimistic update: reflect the new mood immediately ──
    final optimistic = MoodEntryModel(
      id: _todayEntry?.id ?? '',
      userId: widget.userId,
      moodScore: score,
      moodLabel: label,
      note: note,
      entryDate: _todayStr,
      createdAt: DateTime.now(),
    );
    HapticFeedback.heavyImpact();
    _showXpFeedback(score * 5 + 10);
    setState(() {
      _isSubmitting = false;
      _savedToday = true;
      _isEditing = false;
      _todayEntry = optimistic;
      if (wasFirstEntryToday) _streakDays++;
    });
    _writeTodayCache(optimistic, _streakDays);

    try {
      if (_isEditing && prevEntry != null) {
        await _gameService.updateMoodEntry(
          id: prevEntry.id,
          mood: label,
          moodScore: score,
          note: note,
        );
      } else if (prevEntry != null) {
        await _gameService.updateMoodEntry(
          id: prevEntry.id,
          mood: label,
          moodScore: score,
          note: note,
        );
      } else {
        await _gameService.saveMoodEntry(
          userId: widget.userId,
          mood: label,
          moodScore: score,
          note: note,
        );
      }
      // Silently reconcile (gets the real id, accurate streak) — no skeleton.
      await _loadTodayData(silent: true);
    } catch (e) {
      // Roll back the optimistic change.
      if (mounted) {
        setState(() {
          _todayEntry = prevEntry;
          _savedToday = prevSaved;
          _streakDays = prevStreak;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Could not save. Tap to retry.'),
            backgroundColor: context.errorColor,
          ),
        );
        await _writeTodayCache(prevEntry, prevStreak);
      }
    }
  }

  void _showXpFeedback(int xp) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(builder: (_) => _XpBurst(xp: xp, onDone: () => entry.remove()));
    overlay.insert(entry);
  }

  void _enterEditMode() {
    setState(() => _isEditing = true);
    _animController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildSkeleton();
    }

    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          if (_savedToday && !_isEditing)
            _buildTodayDone()
          else ...[
            _buildMoodPicker(),
            if (_selectedMoodIndex != null) ...[
              _buildIntensityRow(),
              _buildJournalSection(),
              _buildSaveButton(),
            ],
          ],
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 8.w, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How are you feeling?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor,
                  ),
                ),
                if (_streakDays > 0)
                  Row(
                    children: [
                      Text('🔥', style: TextStyle(fontSize: 12.sp)),
                      SizedBox(width: 4.w),
                      Text(
                        '$_streakDays-day streak',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF97316),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.calendar_month_rounded,
                color: context.textSecondaryColor, size: 20.sp),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MoodCalendarScreen(userId: widget.userId),
              ),
            ).then((_) => _loadTodayData()),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodPicker() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Wrap(
        spacing: 6.w,
        runSpacing: 8.h,
        children: List.generate(_moods.length, (i) {
          final mood = _moods[i];
          final isSelected = _selectedMoodIndex == i;
          final color = mood['color'] as Color;
          return GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                _selectedMoodIndex = isSelected ? null : i;
                if (!isSelected) {
                  _promptIndex = i % _journalPrompts.length;
                  _animController.forward(from: 0);
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 10.w : 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected ? color : color.withValues(alpha: 0.3),
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(mood['emoji'] as String,
                      style: TextStyle(fontSize: isSelected ? 22.sp : 20.sp)),
                  if (isSelected) ...[
                    SizedBox(width: 4.w),
                    Text(
                      mood['label'] as String,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildIntensityRow() {
    final mood = _moods[_selectedMoodIndex!];
    final color = mood['color'] as Color;
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Intensity',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: List.generate(5, (i) {
              final filled = i < _intensity;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() => _intensity = i + 1);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: EdgeInsets.only(right: 6.w),
                  width: 32.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: filled ? color : color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              );
            }),
            // Label on the right
          ),
        ],
      ),
    );
  }

  Widget _buildJournalSection() {
    return AnimatedBuilder(
      animation: _animController,
      builder: (_, child) => Opacity(
        opacity: _animController.value,
        child: SizeTransition(sizeFactor: _animController, child: child),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Journal',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(
                      () => _promptIndex = (_promptIndex + 1) % _journalPrompts.length),
                  child: Row(
                    children: [
                      Icon(Icons.shuffle_rounded,
                          size: 12.sp, color: context.primaryColor),
                      SizedBox(width: 3.w),
                      Text(
                        'Prompt',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          color: context.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            TextField(
              controller: _journalController,
              focusNode: _journalFocus,
              maxLines: 4,
              minLines: 3,
              decoration: InputDecoration(
                hintText: _journalPrompts[_promptIndex],
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  color: context.textSecondaryColor.withValues(alpha: 0.5),
                  fontStyle: FontStyle.italic,
                ),
                filled: true,
                fillColor: context.backgroundColor.withValues(alpha: 0.5),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: context.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: context.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide:
                      BorderSide(color: context.primaryColor, width: 1.5),
                ),
              ),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                color: context.textPrimaryColor,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    final mood = _moods[_selectedMoodIndex!];
    final color = mood['color'] as Color;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isSubmitting ? null : _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
          ),
          child: _isSubmitting
              ? SizedBox(
                  width: 20.h,
                  height: 20.h,
                  child: const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_rounded, size: 18.sp),
                    SizedBox(width: 6.w),
                    Text(
                      _isEditing ? 'Update Journal' : 'Save Today\'s Mood',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildTodayDone() {
    final entry = _todayEntry;
    if (entry == null) return const SizedBox.shrink();
    var moodIdx = _moods.indexWhere((m) =>
        m['label'] == entry.moodLabel || m['emoji'] == entry.moodLabel);
    if (moodIdx < 0) {
      moodIdx = _moods.indexWhere((m) => m['score'] == entry.moodScore);
    }
    final mood = moodIdx >= 0 ? _moods[moodIdx] : null;
    final color = (mood?['color'] as Color?) ?? context.primaryColor;
    final emoji = (mood?['emoji'] as String?) ?? '🙂';

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: color.withValues(alpha: 0.25)),
            ),
            child: Row(
              children: [
                Text(emoji, style: TextStyle(fontSize: 32.sp)),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mood != null ? mood['label'] as String : 'Recorded',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                      if (entry.note.isNotEmpty)
                        Text(
                          entry.note,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            color: context.textSecondaryColor,
                            fontStyle: FontStyle.italic,
                            height: 1.4,
                          ),
                        )
                      else
                        Text(
                          'No journal entry — tap Edit to add one',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            color:
                                context.textSecondaryColor.withValues(alpha: 0.6),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _enterEditMode,
                  icon: Icon(Icons.edit_outlined,
                      color: context.textSecondaryColor, size: 18.sp),
                  tooltip: 'Edit today\'s entry',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          // XP earned indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome_rounded,
                  size: 12.sp, color: const Color(0xFFFBBF24)),
              SizedBox(width: 4.w),
              Text(
                'Journal XP earned today!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.sp,
                  color: const Color(0xFFFBBF24),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: context.primaryColor,
        ),
      ),
    );
  }
}

// ── Overlay XP burst ─────────────────────────────────────────────────────────
class _XpBurst extends StatefulWidget {
  final int xp;
  final VoidCallback onDone;
  const _XpBurst({required this.xp, required this.onDone});

  @override
  State<_XpBurst> createState() => _XpBurstState();
}

class _XpBurstState extends State<_XpBurst>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<double> _translate;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _opacity = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 20),
      TweenSequenceItem(
          tween: ConstantTween(1.0), weight: 50),
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 0.0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 30),
    ]).animate(_ctrl);
    _translate = Tween(begin: 0.0, end: -60.0)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_ctrl);
    _ctrl.forward().then((_) => widget.onDone());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, _) => Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(0, _translate.value),
            child: Center(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBBF24),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFBBF24).withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome_rounded,
                        color: Colors.white, size: 16.sp),
                    SizedBox(width: 6.w),
                    Text(
                      '+${widget.xp} XP',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
