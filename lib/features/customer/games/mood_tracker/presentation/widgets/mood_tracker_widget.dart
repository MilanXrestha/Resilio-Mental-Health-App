import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  Future<void> _loadTodayData() async {
    setState(() => _isLoading = true);
    try {
      final stats = await _gameService.getUserMoodStats(widget.userId);
      final entries = await _gameService.getUserMoodEntries(widget.userId, limit: 100);

      final today = DateTime.now();
      final todayKey = DateTime(today.year, today.month, today.day);
      final todayMatches = entries.where(
        (e) => DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day) == todayKey,
      ).toList();
      final MoodEntryModel? todayEntry = todayMatches.isNotEmpty ? todayMatches.first : null;

      if (mounted) {
        setState(() {
          _streakDays = (stats['currentStreak'] as int?) ?? 0;
          _todayEntry = todayEntry;
          _savedToday = todayEntry != null;
          _isLoading = false;

          if (todayEntry != null) {
            // Pre-fill from today's entry for potential editing
            final moodIdx = _moods.indexWhere((m) => m['emoji'] == todayEntry.moodLabel);
            _selectedMoodIndex = moodIdx >= 0 ? moodIdx : null;
            _intensity = todayEntry.moodScore.clamp(1, 5);
            _journalController.text = todayEntry.note;
          }
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
    final emoji = mood['emoji'] as String;
    final note = _journalController.text.trim();
    final score = (_intensity + (mood['score'] as int)) ~/ 2;

    try {
      if (_isEditing && _todayEntry != null) {
        await _gameService.updateMoodEntry(
          id: _todayEntry!.id,
          mood: emoji,
          moodScore: score,
          note: note,
        );
      } else {
        await _gameService.saveMoodEntry(
          userId: widget.userId,
          mood: emoji,
          moodScore: score,
          note: note,
        );
      }

      HapticFeedback.heavyImpact();
      if (mounted) {
        final wasFirstEntryToday = !_savedToday;
        _showXpFeedback(score * 5 + 10);
        setState(() {
          _isSubmitting = false;
          _savedToday = true;
          _isEditing = false;
          if (wasFirstEntryToday) _streakDays++;
        });
        await _loadTodayData();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not save: $e'),
            backgroundColor: context.errorColor,
          ),
        );
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
    final moodIdx = _moods.indexWhere((m) => m['emoji'] == entry.moodLabel);
    final mood = moodIdx >= 0 ? _moods[moodIdx] : null;
    final color = (mood?['color'] as Color?) ?? context.primaryColor;

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
                Text(entry.moodLabel, style: TextStyle(fontSize: 32.sp)),
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
