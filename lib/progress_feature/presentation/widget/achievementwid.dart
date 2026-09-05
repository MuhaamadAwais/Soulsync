import 'package:faith/colorapp.dart';
import 'package:faith/firestoreServices.dart';
import 'package:flutter/material.dart';

class Achievementwid extends StatefulWidget {
  final String streakname;
  final String titlename;

  const Achievementwid({
    super.key,
    required this.streakname,
    required this.titlename,
  });

  @override
  State<Achievementwid> createState() => _AchievementwidState();
}

class _AchievementwidState extends State<Achievementwid> {
  final Firestoreservices _firestoreService = Firestoreservices();

  bool isLoading = true;
  int currentStreak = 0;

  @override
  void initState() {
    super.initState();
    checkStreak();
  }

  Future<void> checkStreak() async {
    try {
      final allProgress = await _firestoreService.getAllProgress();

      // Date -> score map
      final Map<String, int> dailyScores = {};

      for (final data in allProgress) {
        final date = data['date'];

        if (date == null) continue;

        final score = data['score'];

        if (score != null) {
          dailyScores[date.toString()] = (score as num).toInt();
        }
      }

      int streak = 0;

      DateTime checkDate = DateTime.now();

      // Check today, yesterday, day before yesterday...
      while (true) {
        final dateString =
            '${checkDate.year}-'
            '${checkDate.month.toString().padLeft(2, '0')}-'
            '${checkDate.day.toString().padLeft(2, '0')}';

        final score = dailyScores[dateString];

        // Day successful only when score is exactly 100
        if (score == 100) {
          streak++;

          checkDate = checkDate.subtract(const Duration(days: 1));
        } else {
          // One skipped day breaks the streak
          break;
        }
      }

      if (mounted) {
        setState(() {
          currentStreak = streak;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Streak error: $e');

      if (mounted) {
        setState(() {
          currentStreak = 0;
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Achievement requirement
    final int requiredDays = widget.streakname.contains('7') ? 7 : 3;

    // Achievement is unlocked only after required consecutive days
    final bool isCompleted = currentStreak >= requiredDays;

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: isLoading
          ? Container(
              width: width,
              height: height * 0.12,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.emeraldGreen),
              ),
            )
          : isCompleted
          ? completeachievement(width, height * 0.12)
          : uncompleteAchievement(width, height * 0.12),
    );
  }

  Widget completeachievement(double width, double height) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.2),
        border: Border.all(width: 2, color: AppColors.gold),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_fire_department,
              color: AppColors.gold,
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.streakname,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  widget.titlename,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),

          const Icon(Icons.check_circle, color: AppColors.gold, size: 28),
        ],
      ),
    );
  }

  Widget uncompleteAchievement(double width, double height) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(width: 2, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_fire_department,
              color: AppColors.gold,
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.streakname,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  widget.titlename,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),

          const Icon(Icons.lock, color: AppColors.gold, size: 28),
        ],
      ),
    );
  }
}
