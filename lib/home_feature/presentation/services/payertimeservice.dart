import 'dart:convert';

import 'package:http/http.dart' as http;

class Payertimeservice {
  Future<Map<String, Map<String, String>>> getprayertime() async {
    final now = DateTime.now();
    final date =
        '${now.day.toString().padLeft(2, '')}-'
        '${now.month.toString().padLeft(2, '')}-'
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
}
