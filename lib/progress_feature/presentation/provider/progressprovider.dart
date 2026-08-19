import 'package:flutter/material.dart';

class Progressprovider with ChangeNotifier {
  int currentStreak = 7;
  int bestStreak = 14;
  double weeklyAverage = 81;

  List<Map<String, dynamic>> achievements = [
    {
      "title": "3 Day Streak",
      "subtitle": "Completed Salah for 3 days",
      "unloack": true,
    },

    {
      "title": "7 Day Streak",
      "subtitle": "Completed Salah for 7 days",
      "unloack": true,
    },
    {
      "title": "15 Day Streak",
      "subtitle": "Completed Salah for 15 days",
      "unloack": true,
    },

    {
      "title": "30 Day Streak",
      "subtitle": "Completed Salah for 30 days",
      "unloack": true,
    },
  ];

  void updateStreak(int value) {
    currentStreak = value;
    notifyListeners();
  }
}
