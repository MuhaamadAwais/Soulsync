import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuranService {
  static const String arabicKey = 'daily_arabic_ayah';
  static const String urduKey = 'daily_urdu_ayah';
  static const String savedDateKey = 'daily_ayah_date';

  Future<Map<String, String>> getDailyAyah() async {
    final prefs = await SharedPreferences.getInstance();

    final now = DateTime.now();

    // Aaj ka 6 AM time
    DateTime today6AM = DateTime(
      now.year,
      now.month,
      now.day,
      6,
    );

    // Agar abhi 6 AM se pehle hain
    // to current daily ayah previous day ki hogi
    if (now.isBefore(today6AM)) {
      today6AM = today6AM.subtract(const Duration(days: 1));
    }

    final currentDailyDate =
        '${today6AM.year}-'
        '${today6AM.month.toString().padLeft(2, '0')}-'
        '${today6AM.day.toString().padLeft(2, '0')}';

    final savedDate = prefs.getString(savedDateKey);

    // Agar aaj ki ayat already saved hai
    if (savedDate == currentDailyDate) {
      return {
        'arabic': prefs.getString(arabicKey) ?? '',
        'urdu': prefs.getString(urduKey) ?? '',
      };
    }

    // New daily ayah
    final randomResponse = await http.get(
      Uri.parse(
        'https://api.alquran.cloud/v1/ayah/random',
      ),
    );

    if (randomResponse.statusCode != 200) {
      throw Exception('Failed to load Arabic ayah');
    }

    final randomData = jsonDecode(randomResponse.body);

    final ayahNumber = randomData['data']['number'];

    final arabicText = randomData['data']['text'];

    // Same ayah ki Urdu translation
    final urduResponse = await http.get(
      Uri.parse(
        'https://api.alquran.cloud/v1/ayah/$ayahNumber/ur.jalandhry',
      ),
    );

    if (urduResponse.statusCode != 200) {
      throw Exception('Failed to load Urdu translation');
    }

    final urduData = jsonDecode(urduResponse.body);

    final urduText = urduData['data']['text'];

    // Save today's ayah
    await prefs.setString(arabicKey, arabicText);
    await prefs.setString(urduKey, urduText);
    await prefs.setString(savedDateKey, currentDailyDate);

    return {
      'arabic': arabicText,
      'urdu': urduText,
    };
  }
}