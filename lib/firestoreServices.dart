import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestoreservices {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get uid => _auth.currentUser!.uid;

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
    required bool dhikrCompeleted,
    required int score,
  }) async {
    await todayProgress.set({
      'date': todaydate,
      'fajr': fajr,
      'dhuhr': dhuhr,
      'asr': asr,
      'maghrib': maghrib,
      'isha': isha,
      'quranCompleted': quranCompleted,
      'dhikrCompleted': dhikrCompeleted,
      'score': score,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getTodayprogress() async {
    final snapshot = await todayProgress.get();
    if (snapshot.exists) {
      return snapshot.data();
    }
    return null;
  }
}
