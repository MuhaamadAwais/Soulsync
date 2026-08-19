import 'package:faith/colorapp.dart';
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
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        setState(() {
          isCompleted = !isCompleted;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
        child: isCompleted
            ? completeachievement(width, height * 0.12, "", "")
            : uncompleteAchievement(width, height * 0.12, "", ""),
      ),
    );
  }

  Widget completeachievement(
    double width,
    double height,
    String streakname,
    String titlename,
  ) {
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
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),

          Icon(Icons.check_circle, color: AppColors.gold, size: 28),
        ],
      ),
    );
  }

  Widget uncompleteAchievement(
    double width,
    double height,
    String streakname,
    String titlename,
  ) {
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
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),

          Icon(Icons.lock, color: AppColors.gold, size: 28),
        ],
      ),
    );
  }
}
