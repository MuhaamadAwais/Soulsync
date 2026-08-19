import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Steekwidprogess extends StatelessWidget {
  final int currentStreak;
  final int bestStreak;
  const Steekwidprogess({
    super.key,
    required this.currentStreak,
    required this.bestStreak,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: height * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.gold,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: height * 0.1,
                height: height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white.withOpacity(0.2),
                ),
                child: Center(
                  child: Icon(
                    Icons.local_fire_department_outlined,
                    color: AppColors.white,
                    size: 40,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${currentStreak} Days",
                    style: TextStyle(color: Colors.white70, fontSize: 16,fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "7 Days",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Personal best: $bestStreak days",
                    style: TextStyle(color: Colors.white70, fontSize: 14,fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Icon(
                Icons.whatshot_outlined,
                size: 40,
                color: AppColors.emeraldGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
