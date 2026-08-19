import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Imagecontiwid extends StatelessWidget {
  const Imagecontiwid({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width * 0.3,
          height: width * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gold,
          ),
          child: Center(
            child: Container(
              width: width * 0.28,
              height: width * 0.28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Center(
                child: Container(
                  width: width * 0.26,
                  height: width * 0.26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.emeraldGreen,
                  ),
                  child: Center(
                    child: Text(
                      "A",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
