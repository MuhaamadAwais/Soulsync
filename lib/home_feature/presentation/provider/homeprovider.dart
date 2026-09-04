import 'package:faith/firestoreServices.dart';
import 'package:flutter/material.dart';

class Homeprovider extends ChangeNotifier {
  final Firestoreservices _firestore = Firestoreservices();

  // ============================================================
  // PRAYER TIMES
  // ============================================================

  Map<String, Map<String, String>> prayerTimes = {};

  // ============================================================
  // DAILY TASKS
  // 0 = Fajr
  // 1 = Dhuhr
  // 2 = Asr
  // 3 = Maghrib
  // 4 = Isha
  // 5 = Quran
  // 6 = Dhikr
  // ============================================================

  List<bool> completed = List<bool>.filled(7, false);

  double score = 0;

  bool _isSaving = false;

  bool get isSaving => _isSaving;

  int get CompletedCount {
    return completed.where((item) => item).length;
  }

  // ============================================================
  // SET PRAYER TIMES
  // ============================================================

  void setPrayerTimes(Map<String, Map<String, String>> times) {
    prayerTimes = times;

    debugPrint('Prayer times loaded: $prayerTimes');

    notifyListeners();
  }

  // ============================================================
  // INITIALIZE TODAY'S DATA
  // ============================================================

  Future<void> initialize() async {
    try {
      debugPrint('Initializing today progress...');

      final data = await _firestore.getTodayprogress();

      if (data == null) {
        debugPrint('No progress found for today.');

        completed = List<bool>.filled(7, false);
        score = 0;

        notifyListeners();

        return;
      }

      completed = [
        data['fajr'] == true,
        data['dhuhr'] == true,
        data['asr'] == true,
        data['maghrib'] == true,
        data['isha'] == true,
        data['quranCompleted'] == true,
        data['dhikrCompleted'] == true,
      ];

      score = (CompletedCount / 7) * 100;
      print("Today's completed: $completed");
      print("Today's score: $score");

      notifyListeners();
    } catch (e) {
      debugPrint('Initialize error: $e');
    }
  }

  // ============================================================
  // CHECK COMPLETED
  // ============================================================

  bool isCompleted(int index) {
    if (index < 0 || index >= completed.length) {
      return false;
    }

    return completed[index];
  }

  // ============================================================
  // TOGGLE / COMPLETE TASK
  // ============================================================

  Future<void> toggleTask(int index) async {
    if (index < 0 || index >= completed.length) {
      return;
    }

    // Already completed
    if (completed[index]) {
      debugPrint('Task $index already completed.');
      return;
    }

    // Prevent multiple taps while saving
    if (_isSaving) {
      debugPrint('Another task is currently being saved.');
      return;
    }

    _isSaving = true;

    // ------------------------------------------------------------
    // FIRST: Update UI immediately
    // ------------------------------------------------------------

    completed[index] = true;

    score = (CompletedCount / 7) * 100;

    notifyListeners();

    debugPrint('Task $index completed locally.');
    debugPrint('Completed: $completed');
    debugPrint('Score: $score');

    // ------------------------------------------------------------
    // SECOND: Save to Firestore
    // ------------------------------------------------------------

    try {
      await _firestore.dailyProgress(
        fajr: completed[0],
        dhuhr: completed[1],
        asr: completed[2],
        maghrib: completed[3],
        isha: completed[4],
        quranCompleted: completed[5],
        dhikrCompleted: completed[6],
        score: score.toInt(),
      );

      debugPrint('SUCCESS: Task $index saved to Firestore.');
    } catch (e) {
      debugPrint('ERROR: Task $index could not be saved.');

      debugPrint('Firestore error: $e');

      // ----------------------------------------------------------
      // Rollback ONLY if Firebase save failed
      // ----------------------------------------------------------

      completed[index] = false;

      score = (CompletedCount / 7) * 100;

      notifyListeners();
    } finally {
      _isSaving = false;
    }
  }

  // ============================================================
  // PRAYER ACTIVE CHECK
  // ============================================================

  bool isPrayerActive(String prayerName) {
    final prayer = prayerTimes[prayerName];

    if (prayer == null) {
      debugPrint('Prayer not found: $prayerName');

      debugPrint('Available prayers: ${prayerTimes.keys}');

      return false;
    }

    final startString = prayer['start'];
    final endString = prayer['end'];

    if (startString == null || endString == null) {
      return false;
    }

    try {
      final start = _parseTime(startString);
      final end = _parseTime(endString);

      final now = TimeOfDay.now();

      final currentMinutes = now.hour * 60 + now.minute;

      final startMinutes = start.hour * 60 + start.minute;

      final endMinutes = end.hour * 60 + end.minute;

      // Isha crosses midnight
      if (endMinutes < startMinutes) {
        return currentMinutes >= startMinutes || currentMinutes < endMinutes;
      }

      return currentMinutes >= startMinutes && currentMinutes < endMinutes;
    } catch (e) {
      debugPrint('Prayer time parse error: $e');

      return false;
    }
  }

  // ============================================================
  // PARSE TIME
  // Supports:
  // 05:12
  // 05:12 AM
  // 05:12 PM
  // ============================================================

  TimeOfDay _parseTime(String time) {
    time = time.trim().toUpperCase();

    final hasPM = time.contains('PM');
    final hasAM = time.contains('AM');

    final cleanTime = time.replaceAll('AM', '').replaceAll('PM', '').trim();

    final parts = cleanTime.split(':');

    int hour = int.parse(parts[0]);
    final int minute = int.parse(parts[1]);

    if (hasPM && hour != 12) {
      hour += 12;
    }

    if (hasAM && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }
}
