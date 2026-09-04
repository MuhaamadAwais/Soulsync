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
      await todayProgress.set(
        {
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
        },
        SetOptions(merge: true),
      );

      print('Firestore saved successfully');
    } catch (e) {
      print('Firestore save error: $e');
      rethrow;
    }
  }

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
}