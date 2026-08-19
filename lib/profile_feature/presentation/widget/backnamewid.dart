import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Backnamewid extends StatelessWidget {
  final String nameabout;
  const Backnamewid({super.key,required this.nameabout});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: width * 0.02),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: width * 0.1,
            height: width * 0.1,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              border: Border.all(width: 1, color: AppColors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Icon(Icons.arrow_back, color: AppColors.white)),
          ),
        ),
        SizedBox(width: width * 0.03),
        Text(
          nameabout,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
