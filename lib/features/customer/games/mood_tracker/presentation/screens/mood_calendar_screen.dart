// screens/mood_calendar_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/features/customer/games/game_hub/data/services/game_service.dart';
import 'package:Resilio/features/customer/games/mood_tracker/data/models/mood_entry_model.dart';
import 'package:Resilio/features/customer/games/mood_tracker/presentation/widgets/mood_share_sheet.dart';

class MoodCalendarScreen extends StatefulWidget {
  final String userId;
  const MoodCalendarScreen({super.key, required this.userId});

  @override
  State<MoodCalendarScreen> createState() => _MoodCalendarScreenState();
}

class _Mood {
  final String emoji;
  final String label;
  final int score;
  final Color color;
  const _Mood(this.emoji, this.label, this.score, this.color);
}

const _moods = <_Mood>[
  _Mood('😄', 'Joyful', 5, Color(0xFFFBBF24)),
  _Mood('😊', 'Happy', 4, Color(0xFF34D399)),
  _Mood('😌', 'Calm', 4, Color(0xFF60A5FA)),
  _Mood('😐', 'Neutral', 3, Color(0xFF94A3B8)),
  _Mood('😔', 'Sad', 2, Color(0xFF818CF8)),
  _Mood('😰', 'Anxious', 2, Color(0xFFF97316)),
  _Mood('😡', 'Angry', 1, Color(0xFFEF4444)),
  _Mood('😴', 'Tired', 2, Color(0xFF8B5CF6)),
];

String _emojiForScore(int s) {
  switch (s) {
    case 5:
      return '😄';
    case 4:
      return '😊';
    case 3:
      return '😐';
    case 2:
      return '😔';
    default:
      return '😡';
  }
}

Color _colorForScore(int s) {
  switch (s) {
    case 5:
      return const Color(0xFFFBBF24);
    case 4:
      return const Color(0xFF34D399);
    case 3:
      return const Color(0xFF94A3B8);
    case 2:
      return const Color(0xFF818CF8);
    default:
      return const Color(0xFFEF4444);
  }
}

class _MoodCalendarScreenState extends State<MoodCalendarScreen> {
  final GameService _gameService = GameService();

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.month;

  final Map<DateTime, MoodEntryModel> _entries = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  DateTime _key(DateTime d) => DateTime(d.year, d.month, d.day);

  DateTime _entryDay(MoodEntryModel e) {
    final parsed = DateTime.tryParse(e.entryDate);
    return _key(parsed ?? e.createdAt);
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    try {
      final entries =
          await _gameService.getUserMoodEntries(widget.userId, limit: 365);
      final map = <DateTime, MoodEntryModel>{};
      for (final e in entries) {
        map[_entryDay(e)] = e;
      }
      if (!mounted) return;
      setState(() {
        _entries
          ..clear()
          ..addAll(map);
        _isLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  MoodEntryModel? _entryFor(DateTime day) => _entries[_key(day)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Mood Journal',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        iconTheme: IconThemeData(color: context.textPrimaryColor),
        actions: [
          IconButton(
            tooltip: 'Share with therapist',
            icon: Icon(Icons.ios_share_rounded,
                color: context.textPrimaryColor, size: 22.sp),
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: context.surfaceColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              builder: (_) => const MoodShareSheet(),
            ),
          ),
        ],
      ),
      // Render immediately; entries fill in when the fetch finishes (a thin
      // bar shows while loading). Blocking the whole screen made navigation
      // feel like it hung on slow connections.
      body: Column(
        children: [
          if (_isLoading)
            LinearProgressIndicator(
              minHeight: 2.h,
              color: context.primaryColor,
              backgroundColor: Colors.transparent,
            ),
          Expanded(
            child: RefreshIndicator(
              color: context.primaryColor,
              onRefresh: _load,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
                children: [
                  _buildStatsBar(context),
                  SizedBox(height: 16.h),
                  _buildCalendarCard(context),
                  SizedBox(height: 16.h),
                  _buildSelectedDay(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBar(BuildContext context) {
    final total = _entries.length;
    final avg = total == 0
        ? 0.0
        : _entries.values.map((e) => e.moodScore).reduce((a, b) => a + b) /
            total;
    return Row(
      children: [
        Expanded(
          child: _statTile(context, '📊', '$total', 'entries'),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _statTile(
              context, _emojiForScore(avg.round().clamp(1, 5)),
              avg == 0 ? '—' : avg.toStringAsFixed(1), 'avg mood'),
        ),
      ],
    );
  }

  Widget _statTile(BuildContext context, String emoji, String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: 22.sp)),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: context.textPrimaryColor)),
              Text(label,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.sp,
                      color: context.textSecondaryColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.3)),
      ),
      child: TableCalendar<MoodEntryModel>(
        firstDay: DateTime.utc(2022, 1, 1),
        lastDay: DateTime.now(),
        focusedDay: _focusedDay,
        calendarFormat: _format,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
          CalendarFormat.twoWeeks: '2 weeks',
        },
        selectedDayPredicate: (d) => isSameDay(d, _selectedDay),
        eventLoader: (d) {
          final e = _entryFor(d);
          return e != null ? [e] : [];
        },
        onDaySelected: (sel, foc) {
          setState(() {
            _selectedDay = sel;
            _focusedDay = foc;
          });
        },
        onFormatChanged: (f) => setState(() => _format = f),
        onPageChanged: (foc) => _focusedDay = foc,
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonDecoration: BoxDecoration(
            color: context.primaryColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12.r),
          ),
          formatButtonTextStyle:
              TextStyle(color: context.primaryColor, fontSize: 12.sp),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
          leftChevronIcon:
              Icon(Icons.chevron_left_rounded, color: context.textPrimaryColor),
          rightChevronIcon: Icon(Icons.chevron_right_rounded,
              color: context.textPrimaryColor),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
              color: context.textSecondaryColor, fontSize: 11.sp),
          weekendStyle: TextStyle(
              color: context.textSecondaryColor, fontSize: 11.sp),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: TextStyle(color: context.textPrimaryColor),
          weekendTextStyle: TextStyle(color: context.textPrimaryColor),
        ),
        calendarBuilders: CalendarBuilders<MoodEntryModel>(
          markerBuilder: (context, day, events) {
            if (events.isEmpty) return null;
            return Positioned(
              bottom: 2,
              child: Text(_emojiForScore(events.first.moodScore),
                  style: TextStyle(fontSize: 12.sp)),
            );
          },
          selectedBuilder: (context, day, _) => Container(
            margin: EdgeInsets.all(4.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Text('${day.day}',
                style: const TextStyle(color: Colors.white)),
          ),
          todayBuilder: (context, day, _) => Container(
            margin: EdgeInsets.all(4.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.primaryColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Text('${day.day}',
                style: TextStyle(color: context.textPrimaryColor)),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedDay(BuildContext context) {
    final entry = _entryFor(_selectedDay);
    final isFuture = _key(_selectedDay).isAfter(_key(DateTime.now()));
    final dateLabel = DateFormat('EEEE, MMM d').format(_selectedDay);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.borderColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dateLabel,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textSecondaryColor)),
          SizedBox(height: 14.h),
          if (entry != null) ...[
            Row(
              children: [
                Text(_emojiForScore(entry.moodScore),
                    style: TextStyle(fontSize: 40.sp)),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    entry.moodLabel.isNotEmpty
                        ? entry.moodLabel
                        : 'Mood ${entry.moodScore}/5',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: _colorForScore(entry.moodScore)),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit_rounded,
                      color: context.primaryColor, size: 22.sp),
                  onPressed: () => _openEditor(entry: entry),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: context.backgroundColor,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Text(
                entry.note.isNotEmpty ? entry.note : 'No note for this day.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  height: 1.5,
                  color: entry.note.isNotEmpty
                      ? context.textPrimaryColor
                      : context.textSecondaryColor,
                ),
              ),
            ),
          ] else ...[
            Row(
              children: [
                Text('🗓️', style: TextStyle(fontSize: 32.sp)),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    isFuture
                        ? 'You can log this day when it arrives.'
                        : 'No mood logged for this day.',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        color: context.textSecondaryColor),
                  ),
                ),
              ],
            ),
            if (!isFuture) ...[
              SizedBox(height: 14.h),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _openEditor(entry: null),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Log mood'),
                  style: FilledButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  // Bottom-sheet editor: pick mood + write a note. Updates an existing entry
  // or creates one for the selected day.
  void _openEditor({required MoodEntryModel? entry}) {
    int score = entry?.moodScore ?? 3;
    String label = entry?.moodLabel ?? 'Neutral';
    final noteCtrl = TextEditingController(text: entry?.note ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (sheetCtx, setSheet) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 16.h,
                bottom: MediaQuery.of(sheetCtx).viewInsets.bottom + 24.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: context.textSecondaryColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    DateFormat('EEEE, MMM d').format(_selectedDay),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: context.textPrimaryColor),
                  ),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: _moods.map((m) {
                      final selected = m.label == label && m.score == score;
                      return GestureDetector(
                        onTap: () => setSheet(() {
                          score = m.score;
                          label = m.label;
                        }),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: selected
                                ? m.color.withValues(alpha: 0.2)
                                : context.backgroundColor,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: selected ? m.color : context.borderColor,
                              width: selected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(m.emoji, style: TextStyle(fontSize: 18.sp)),
                              SizedBox(width: 6.w),
                              Text(m.label,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: context.textPrimaryColor)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: noteCtrl,
                    maxLines: 4,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        color: context.textPrimaryColor),
                    decoration: InputDecoration(
                      hintText: "What's on your mind?",
                      hintStyle: TextStyle(color: context.textSecondaryColor),
                      filled: true,
                      fillColor: context.backgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        Navigator.pop(sheetCtx);
                        await _saveEntry(
                          entry: entry,
                          score: score,
                          label: label,
                          note: noteCtrl.text.trim(),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: context.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(entry == null ? 'Save' : 'Update',
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _saveEntry({
    required MoodEntryModel? entry,
    required int score,
    required String label,
    required String note,
  }) async {
    try {
      if (entry != null) {
        await _gameService.updateMoodEntry(
          id: entry.id,
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
          entryDate: DateFormat('yyyy-MM-dd').format(_selectedDay),
        );
      }
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(entry == null ? 'Mood logged' : 'Mood updated'),
            backgroundColor: context.primaryColor,
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save. Try again.')),
        );
      }
    }
  }
}
