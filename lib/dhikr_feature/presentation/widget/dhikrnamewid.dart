import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Dhikrnamewid extends StatelessWidget {
  final Animation<double> fadeanimation;
  final Animation<Offset> slideAnimation;
  final String arabic;
  final String english;
  const Dhikrnamewid({
    super.key,
    required this.arabic,
    required this.english,
    required this.fadeanimation,
    required this.slideAnimation,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: fadeanimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Text(
              arabic,
              style: TextStyle(
                color: AppColors.emeraldGreen,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Text(
          english,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
