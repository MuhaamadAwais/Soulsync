import 'package:faith/colorapp.dart';
import 'package:faith/profile_feature/presentation/widget/backnamewid.dart';
import 'package:faith/profile_feature/presentation/widget/imagecontiwid.dart';
import 'package:flutter/material.dart';

class Maineditwid extends StatelessWidget {
  const Maineditwid({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.4,
      color: AppColors.emeraldGreen,
      child: Column(
        children: [
        
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Backnamewid(nameabout: 'Edit Profile'),
          ),
          SizedBox(height: height * 0.04),
          Imagecontiwid(),
          SizedBox(height: height * 0.02),
         ],
      ),
    );
  }
}
