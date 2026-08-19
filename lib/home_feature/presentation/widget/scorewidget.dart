import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Scorewidget extends StatelessWidget {
  final double score;
  final int CompletedCount;
  const Scorewidget({
    super.key,
    required this.score,
    required this.CompletedCount,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: height * 0.25,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.white.withOpacity(0.08),
          border: Border.all(color: AppColors.white.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Faith Score",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Text(
                          "${score.toInt()}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.percent, color: AppColors.gold),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "$CompletedCount of 7 done",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: width * 0.3,
                  height: width * 0.3,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.25,
                        height: width * 0.25,
                        child: CircularProgressIndicator(
                          value: score / 100,
                          strokeWidth: 6,
                          color: AppColors.gold,
                        ),
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: AppColors.gold, size: 35),

                          SizedBox(height: 4),

                          Text(
                            "Faith",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: score / 100,
                minHeight: 10,
                backgroundColor: Colors.white.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation(AppColors.gold),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Daily Completion",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
