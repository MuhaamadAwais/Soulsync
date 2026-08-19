import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Faithstatwid extends StatelessWidget {
  const Faithstatwid({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: width,
          height: height * 0.2,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                height: height * 0.05,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.emeraldGreen.withOpacity(0.2),
                      AppColors.gold.withOpacity(0.2),
                    ],
                    begin: AlignmentGeometry.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "FAITH STATISTICS",
                    style: TextStyle(
                      color: AppColors.emeraldGreen,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    // Faith Score
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: AppColors.gold),
                          const SizedBox(height: 5),
                          Text(
                            "85%",
                            style: TextStyle(
                              color: AppColors.emeraldGreen,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            "Faith Score",
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    Container(height: 60, width: 1.5, color: AppColors.gold),

                    // Streak
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "25",
                            style: TextStyle(
                              color: AppColors.emeraldGreen,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            "Streak",
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    Container(height: 60, width: 1.5, color: AppColors.gold),

                    // Dhikr
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.favorite, color: Colors.red),
                          const SizedBox(height: 5),
                          Text(
                            "500",
                            style: TextStyle(
                              color: AppColors.emeraldGreen,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            "Dhikr",
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
