import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Payertimeservice {
  Future<Map<String, Map<String, String>>> getprayertime() async {
    final now = DateTime.now();
    final date =
        '${now.day.toString().padLeft(2, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.year}';

    final url = await Uri.parse(
      'https://api.aladhan.com/v1/timingsByCity/$date'
      '?city=Bahawalpur&country=Pakistan&method=1&school=1',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final timings = data['data']['timings'];
      return {
        'Fajr': {
          'start': timings['Fajr'].toString(),
          'end': timings['Sunrise'].toString(),
        },
        'Dhuhr': {
          'start': timings['Dhuhr'].toString(),
          'end': timings['Asr'].toString(),
        },

        'Asr': {
          'start': timings['Asr'].toString(),
          'end': timings['Maghrib'].toString(),
        },

        'Maghrib': {
          'start': timings['Maghrib'].toString(),
          'end': timings['Isha'].toString(),
        },
        'Isha': {
          'start': timings['Isha'].toString(),
          'end': timings['Fajr'].toString(),
        },
      };
    } else {
      throw Exception('Failed to laod prayer times: ${response.statusCode}');
    }
  }

  // Poore mahine ka data: pehle saved se, warna internet se
  Future<List<dynamic>?> _getMonth(int year, int month) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'prayer_month_$year-$month';

    // 1) Saved ho to wahi use karo (offline bhi chalega)
    final cached = prefs.getString(key);
    if (cached != null) return jsonDecode(cached) as List;

    // 2) Nahi hai to internet se lo aur save kar lo
    try {
      final url = Uri.parse(
        'https://api.aladhan.com/v1/calendarByCity/$year/$month'
        '?city=Bahawalpur&country=Pakistan&method=1&school=1',
      );
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final days = jsonDecode(response.body)['data'] as List;
        await prefs.setString(key, jsonEncode(days));
        return days;
      }
    } catch (_) {
      // offline: null return hoga
    }
    return null;
  }

  // Kisi bhi din ke 5 namaz ke start time, jaise {'Fajr': '05:15', ...}
  Future<Map<String, String>?> getStartTimesForDate(DateTime date) async {
    final days = await _getMonth(date.year, date.month);
    if (days == null || date.day > days.length) return null;

    final timings = days[date.day - 1]['timings'];
    String clean(dynamic raw) =>
        RegExp(r'\d{1,2}:\d{2}').firstMatch(raw.toString())!.group(0)!;

    return {
      'Fajr': clean(timings['Fajr']),
      'Dhuhr': clean(timings['Dhuhr']),
      'Asr': clean(timings['Asr']),
      'Maghrib': clean(timings['Maghrib']),
      'Isha': clean(timings['Isha']),
    };
  }
}
