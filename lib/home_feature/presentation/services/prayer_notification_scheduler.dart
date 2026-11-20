import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;

import 'notification_service.dart';
import 'payertimeservice.dart'; // apna sahi path lagao

class PrayerNotificationScheduler {
  static const _prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
  static const _daysAhead = 7;
  static const _baseId = 100; // test wali id 0 se na takraye
  static const _urduNames = {
    'Fajr': 'فجر',
    'Dhuhr': 'ظہر',
    'Asr': 'عصر',
    'Maghrib': 'مغرب',
    'Isha': 'عشاء',
  };
  final _service = Payertimeservice();

  Future<void> scheduleUpcoming() async {
    final notif = NotificationService.instance;

    // Pehle purani prayer notifications hata do
    await notif.cancelRange(_baseId, _baseId + _daysAhead * 10);

    // Switch OFF hai to naya kuch schedule mat karo
    if (!await notif.isEnabled()) return;

    final now = tz.TZDateTime.now(tz.local);

    for (var day = 0; day < _daysAhead; day++) {
      final date = DateTime.now().add(Duration(days: day));

      final times = await _service.getStartTimesForDate(date);
      if (times == null) continue; // is din ka data nahi mila

      for (var i = 0; i < _prayers.length; i++) {
        final name = _prayers[i];
        final raw = times[name];
        if (raw == null) continue;

        final match = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(raw);
        if (match == null) {
          debugPrint('Bad time format for $name: $raw');
          continue;
        }

        var hour = int.parse(match.group(1)!);
        final minute = int.parse(match.group(2)!);

        // Agar "5:12 PM" jaisa format ho
        final upper = raw.toUpperCase();
        if (upper.contains('PM') && hour < 12) hour += 12;
        if (upper.contains('AM') && hour == 12) hour = 0;

        final when = tz.TZDateTime(
          tz.local,
          date.year,
          date.month,
          date.day,
          hour,
          minute,
        );

        if (when.isBefore(now)) continue; // guzra hua waqt chhor do

        await notif.scheduleOnce(
          id: _baseId + day * 10 + i,
          title: 'نمازِ ${_urduNames[name]} کا وقت ہو گیا ہے',
          body:
              'اپنے کام روک کر اللہ کی عبادت کے لیے وقت نکالیں اور نماز ادا فرمائیں۔',
          when: when,
        );
      }
    }
  }
}
