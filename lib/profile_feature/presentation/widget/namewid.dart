import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Namewid extends StatelessWidget {
  const Namewid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Abdullah Rehman",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        Text("abdullah.r@gmial.com",style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),),
      ],
    );
  }
}
