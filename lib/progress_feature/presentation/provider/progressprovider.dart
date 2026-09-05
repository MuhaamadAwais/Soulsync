import 'package:faith/firestoreServices.dart';
import 'package:flutter/material.dart';

class Progressprovider with ChangeNotifier {
  final Firestoreservices _firestore = Firestoreservices();

  int totalPrayers = 0;
  int quranDays = 0;
  int dhikrDays = 0;

  bool isLoading = false;

  int currentStreak = 0;
  int bestStreak = 0;
  double weeklyAverage = 0;

  List<Map<String, dynamic>> achievements = [
    {
      "title": "3 Day Streak",
      "subtitle": "Completed Salah for 3 days",
      "unloack": false,
    },
    {
      "title": "7 Day Streak",
      "subtitle": "Completed Salah for 7 days",
      "unloack": false,
    },
  ];

  Future<void> loadProgress() async {
    try {
      isLoading = true;
      notifyListeners();

      final data = await _firestore.getAllProgress();

      int prayers = 0;
      int quran = 0;
      int dhikr = 0;

      for (final day in data) {
        // 5 prayers count
        if (day['fajr'] == true) {
          prayers++;
        }

        if (day['dhuhr'] == true) {
          prayers++;
        }

        if (day['asr'] == true) {
          prayers++;
        }

        if (day['maghrib'] == true) {
          prayers++;
        }

        if (day['isha'] == true) {
          prayers++;
        }

        // Quran days
        if (day['quranCompleted'] == true) {
          quran++;
        }

        // Dhikr days
        if (day['dhikrCompleted'] == true) {
          dhikr++;
        }
      }

      totalPrayers = prayers;
      quranDays = quran;
      dhikrDays = dhikr;
    } catch (e) {
      debugPrint('Progress loading error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateStreak(int value) {
    currentStreak = value;
    notifyListeners();
  }
}
