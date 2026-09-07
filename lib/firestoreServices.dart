import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestoreservices {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get uid {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not signed in');
    }

    return user.uid;
  }

  String get todaydate {
    final now = DateTime.now();

    return '${now.year}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  DocumentReference<Map<String, dynamic>> get todayProgress {
    return _firebase
        .collection('users')
        .doc(uid)
        .collection('daily_progress')
        .doc(todaydate);
  }

  // Save daily progress
  Future<void> dailyProgress({
    required bool fajr,
    required bool dhuhr,
    required bool asr,
    required bool maghrib,
    required bool isha,
    required bool quranCompleted,
    required bool dhikrCompleted,
    required int score,
  }) async {
    try {
      await todayProgress.set({
        'date': todaydate,
        'fajr': fajr,
        'dhuhr': dhuhr,
        'asr': asr,
        'maghrib': maghrib,
        'isha': isha,
        'quranCompleted': quranCompleted,
        'dhikrCompleted': dhikrCompleted,
        'score': score,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print('Firestore saved successfully');
    } catch (e) {
      print('Firestore save error: $e');
      rethrow;
    }
  }

  // Get today's progress
  Future<Map<String, dynamic>?> getTodayprogress() async {
    try {
      final snapshot = await todayProgress.get();

      if (snapshot.exists) {
        return snapshot.data();
      }

      return null;
    } catch (e) {
      print('Firestore read error: $e');
      return null;
    }
  }

  Future<int> getStreak() async {
    try {
      final snapshot = await _firebase
          .collection('users')
          .doc(uid)
          .collection('daily_progress')
          .get();

      if (snapshot.docs.isEmpty) {
        return 0;
      }

      final completedDates = <DateTime>[];

      for (final doc in snapshot.docs) {
        final data = doc.data();

        final score = data['score'];

        if (score is num && score.toInt() >= 100) {
          try {
            final date = DateTime.parse(doc.id);

            completedDates.add(DateTime(date.year, date.month, date.day));
          } catch (e) {
            print('Invalid date: ${doc.id}');
          }
        }
      }

      if (completedDates.isEmpty) {
        return 0;
      }

      completedDates.sort((a, b) => b.compareTo(a));

      final now = DateTime.now();

      final today = DateTime(now.year, now.month, now.day);

      // Latest completed day
      final latestDate = completedDates.first;

      // If today is not completed and yesterday is also not completed,
      // current streak is 0.
      if (latestDate != today) {
        final yesterday = today.subtract(const Duration(days: 1));

        if (latestDate != yesterday) {
          return 0;
        }
      }

      int streak = 0;

      DateTime checkDate = latestDate == today
          ? today
          : today.subtract(const Duration(days: 1));

      for (final date in completedDates) {
        if (date == checkDate) {
          streak++;

          checkDate = checkDate.subtract(const Duration(days: 1));
        } else if (date.isBefore(checkDate)) {
          break;
        }
      }

      return streak;
    } catch (e) {
      print('Get streak error: $e');
      return 0;
    }
  }

  // Get all progress
  Future<List<Map<String, dynamic>>> getAllProgress() async {
    try {
      final snapshot = await _firebase
          .collection('users')
          .doc(uid)
          .collection('daily_progress')
          .get();

      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    } catch (e) {
      print('Get all progress error: $e');
      return [];
    }
  }
}
