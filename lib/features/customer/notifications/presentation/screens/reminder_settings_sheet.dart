import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import '../../../../../core/theme/app_colors.dart';

class ReminderSettingsSheet extends StatefulWidget {
  const ReminderSettingsSheet({super.key});

  @override
  State<ReminderSettingsSheet> createState() => _ReminderSettingsSheetState();
}

class _ReminderSettingsSheetState extends State<ReminderSettingsSheet> {
  static const _prefKeyEnabled = 'reminder_enabled';
  static const _prefKeyHour = 'reminder_hour';
  static const _prefKeyMinute = 'reminder_minute';
  static const _prefKeyType = 'reminder_content_type';

  static const _notificationId = 42;

  final _plugin = FlutterLocalNotificationsPlugin();

  bool _enabled = false;
  TimeOfDay _time = const TimeOfDay(hour: 8, minute: 0);
  String _contentType = 'mixed'; // 'tips', 'quotes', 'mixed'
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
    // Initialise, then ask for permissions once the sheet is on screen so the
    // exact-alarm explainer dialog has a valid context.
    _setup();
  }

  Future<void> _setup() async {
    await _initPlugin();
    if (!mounted) return;
    await _requestPermissions();
  }

  Future<void> _initPlugin() async {
    tz.initializeTimeZones();
    // Set the local timezone so scheduled notifications fire at the correct
    // local time instead of UTC.
    // On Android 7+ DateTime.now().timeZoneName returns the IANA name
    // (e.g. "Asia/Kathmandu"). On older devices it may be an abbreviation
    // or "GMT+HH:MM" — we try the name first, then fall back to UTC.
    _setLocalTimezone();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
    );
  }

  /// Requests notification + exact-alarm permissions. If exact alarms aren't
  /// allowed (Android 12+), shows an explainer then opens the system screen so
  /// the reminder can fire at the precise time the user picked.
  Future<void> _requestPermissions() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return;

    // Android 13+ POST_NOTIFICATIONS runtime prompt.
    await android.requestNotificationsPermission();

    // Android 12+ exact-alarm gate.
    final canExact = await android.canScheduleExactNotifications() ?? true;
    if (canExact || !mounted) return;

    final proceed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Allow exact reminders'),
        content: const Text(
          'To send your daily wellness reminder at the exact time you choose, '
          'Resilio needs the "Alarms & reminders" permission. '
          'Tap Allow, then enable it on the next screen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Not now'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    if (proceed == true) {
      // Opens the system "Alarms & reminders" settings screen.
      await android.requestExactAlarmsPermission();
    }
  }

  void _setLocalTimezone() {
    // Try the IANA name that Dart exposes on modern Android/iOS.
    final tzName = DateTime.now().timeZoneName;
    try {
      tz.setLocalLocation(tz.getLocation(tzName));
      return;
    } catch (_) {}
    // Fallback: match by UTC offset (picks the first zone with the same offset).
    final offsetSeconds = DateTime.now().timeZoneOffset.inSeconds;
    for (final loc in tz.timeZoneDatabase.locations.values) {
      if (loc.currentTimeZone.offset == offsetSeconds) {
        tz.setLocalLocation(loc);
        return;
      }
    }
    // Last resort: stay with UTC — notification fires at the wrong clock time
    // but at least it fires.
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _enabled = prefs.getBool(_prefKeyEnabled) ?? false;
      _time = TimeOfDay(
        hour: prefs.getInt(_prefKeyHour) ?? 8,
        minute: prefs.getInt(_prefKeyMinute) ?? 0,
      );
      _contentType = prefs.getString(_prefKeyType) ?? 'mixed';
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      // 1. Always persist preferences — this cannot fail
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefKeyEnabled, _enabled);
      await prefs.setInt(_prefKeyHour, _time.hour);
      await prefs.setInt(_prefKeyMinute, _time.minute);
      await prefs.setString(_prefKeyType, _contentType);

      // 2. Cancel any existing reminder (best-effort)
      try {
        await _plugin.cancel(id: _notificationId);
      } catch (_) {}

      // 3. Schedule if enabled — isolated try/catch so a permission error
      //    doesn't prevent the sheet from closing
      String? scheduleError;
      if (_enabled) {
        try {
          await _scheduleDaily();
        } catch (e) {
          scheduleError = e.toString();
        }
      }

      if (mounted) {
        Navigator.of(context).pop();
        final msg = scheduleError != null
            ? 'Settings saved — please grant notification permission in your device settings'
            : _enabled
                ? 'Reminder set for ${_time.format(context)} daily'
                : 'Reminder turned off';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: scheduleError != null
                ? context.errorColor
                : (_enabled ? context.successColor : context.textSecondaryColor),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          ),
        );
      }
    } catch (e) {
      // Prefs save itself failed (extremely unlikely)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not save: ${e.toString()}'),
            backgroundColor: context.errorColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _scheduleDaily() async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      _time.hour,
      _time.minute,
    );
    // If the time has already passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    final contentLabel = _contentType == 'tips'
        ? 'a wellness tip'
        : _contentType == 'quotes'
            ? 'an inspiring quote'
            : 'your daily wellness boost';

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'resilio_reminders',
        'Daily Reminders',
        channelDescription: 'Daily wellness reminders from Resilio',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        color: const Color(0xFF14B8A6),
      ),
      iOS: const DarwinNotificationDetails(
        categoryIdentifier: 'reminder',
      ),
    );

    Future<void> schedule(AndroidScheduleMode mode) => _plugin.zonedSchedule(
          id: _notificationId,
          title: 'Your Daily Wellness Check-in 🌱',
          body: 'Open the app for $contentLabel — small steps, big progress.',
          scheduledDate: scheduledDate,
          notificationDetails: details,
          androidScheduleMode: mode,
          matchDateTimeComponents: DateTimeComponents.time, // repeat daily
        );

    try {
      // Preferred: exact firing. Requires the exact-alarm permission (Android 12+).
      await schedule(AndroidScheduleMode.exactAllowWhileIdle);
    } catch (_) {
      // Exact alarm not permitted → inexact still fires (approximate time) and
      // needs no special permission, so the reminder always works.
      await schedule(AndroidScheduleMode.inexactAllowWhileIdle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32.h,
      ),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40.w, height: 4.h,
              decoration: BoxDecoration(color: context.dividerColor, borderRadius: BorderRadius.circular(2.r)),
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: context.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.alarm_rounded, color: context.primaryColor, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Daily Reminder', style: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
                  Text('Build your wellness habit', style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor)),
                ],
              ),
              const Spacer(),
              Switch.adaptive(
                value: _enabled,
                onChanged: (v) => setState(() => _enabled = v),
                activeColor: context.primaryColor,
              ),
            ],
          ),
          SizedBox(height: 24.h),

          if (_enabled) ...[
            // Time picker
            Text('Remind me at', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w600, color: context.textSecondaryColor)),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () async {
                final picked = await showTimePicker(context: context, initialTime: _time);
                if (picked != null) setState(() => _time = picked);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: context.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: context.primaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _time.format(context),
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 28.sp, fontWeight: FontWeight.w700, color: context.primaryColor),
                    ),
                    Icon(Icons.edit_rounded, color: context.primaryColor, size: 18.sp),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Content type
            Text('Content type', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w600, color: context.textSecondaryColor)),
            SizedBox(height: 8.h),
            Row(
              children: [
                _TypeChip(label: 'Tips', icon: Icons.lightbulb_outline_rounded, value: 'tips', selected: _contentType == 'tips', onTap: () => setState(() => _contentType = 'tips')),
                SizedBox(width: 8.w),
                _TypeChip(label: 'Quotes', icon: Icons.format_quote_rounded, value: 'quotes', selected: _contentType == 'quotes', onTap: () => setState(() => _contentType = 'quotes')),
                SizedBox(width: 8.w),
                _TypeChip(label: 'Mixed', icon: Icons.shuffle_rounded, value: 'mixed', selected: _contentType == 'mixed', onTap: () => setState(() => _contentType = 'mixed')),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'You\'ll get a daily notification at the chosen time with fresh ${_contentType == 'mixed' ? 'wellness content' : _contentType}.',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor, height: 1.5),
            ),
            SizedBox(height: 24.h),
          ] else ...[
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: context.surfaceColor,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: context.borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: context.textSecondaryColor, size: 18.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Enable the toggle above to schedule a daily wellness reminder at your preferred time.',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],

          // Save button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                elevation: 0,
                textStyle: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              child: _saving
                  ? SizedBox(height: 20.h, width: 20.h, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text(_enabled ? 'Save Reminder' : 'Turn Off Reminder'),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  const _TypeChip({required this.label, required this.icon, required this.value, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : context.surfaceColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: selected ? context.primaryColor : context.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14.sp, color: selected ? Colors.white : context.textSecondaryColor),
            SizedBox(width: 5.w),
            Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, fontWeight: FontWeight.w600, color: selected ? Colors.white : context.textSecondaryColor)),
          ],
        ),
      ),
    );
  }
}
