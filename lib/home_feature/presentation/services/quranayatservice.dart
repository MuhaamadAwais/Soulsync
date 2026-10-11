import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuranService {
  static const String arabicKey = 'daily_arabic_ayah';
  static const String urduKey = 'daily_urdu_ayah';
  static const String savedDateKey = 'daily_ayah_date';

  Future<Map<String, String>> getDailyAyah() async {
    final prefs = await SharedPreferences.getInstance();

    final now = DateTime.now();

    DateTime today6AM = DateTime(now.year, now.month, now.day, 6);

    if (now.isBefore(today6AM)) {
      today6AM = today6AM.subtract(const Duration(days: 1));
    }

    final currentDailyDate =
        '${today6AM.year}-'
        '${today6AM.month.toString().padLeft(2, '0')}-'
        '${today6AM.day.toString().padLeft(2, '0')}';

    final savedDate = prefs.getString(savedDateKey);

    // ============================================================
    // ALREADY SAVED AYAH
    // ============================================================

    if (savedDate == currentDailyDate) {
      return {
        'arabic': prefs.getString(arabicKey) ?? '',
        'urdu': prefs.getString(urduKey) ?? '',
      };
    }

    // ============================================================
    // NEW AYAH FROM API
    // ============================================================

    try {
      final randomResponse = await http
          .get(Uri.parse('https://api.alquran.cloud/v1/ayah/random'))
          .timeout(const Duration(seconds: 5));

      if (randomResponse.statusCode != 200) {
        throw Exception('Failed to load Arabic ayah');
      }

      final randomData = jsonDecode(randomResponse.body);

      final ayahNumber = randomData['data']['number'];

      final arabicText = randomData['data']['text'];

      // ==========================================================
      // URDU
      // ==========================================================

      final urduResponse = await http
          .get(
            Uri.parse(
              'https://api.alquran.cloud/v1/ayah/$ayahNumber/ur.jalandhry',
            ),
          )
          .timeout(const Duration(seconds: 5));

      if (urduResponse.statusCode != 200) {
        throw Exception('Failed to load Urdu translation');
      }

      final urduData = jsonDecode(urduResponse.body);

      final urduText = urduData['data']['text'];

      // ==========================================================
      // SAVE
      // ==========================================================

      await prefs.setString(arabicKey, arabicText);

      await prefs.setString(urduKey, urduText);

      await prefs.setString(savedDateKey, currentDailyDate);

      return {'arabic': arabicText, 'urdu': urduText};
    }
    // ============================================================
    // NO INTERNET / API ERROR
    // ============================================================
    catch (e) {
      debugPrint('Quran API error: $e');

      // Purani saved ayat show karo
      final savedArabic = prefs.getString(arabicKey);

      final savedUrdu = prefs.getString(urduKey);

      if (savedArabic != null &&
          savedArabic.isNotEmpty &&
          savedUrdu != null &&
          savedUrdu.isNotEmpty) {
        return {'arabic': savedArabic, 'urdu': savedUrdu};
      }

      // Agar pehli dafa app open hui hai
      // aur koi ayat save nahi hai
      return {'arabic': '', 'urdu': ''};
    }
  }
}
