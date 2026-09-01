import 'package:faith/colorapp.dart';
import 'package:faith/profile_feature/presentation/provider/nameprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Namewid extends StatelessWidget {
  const Namewid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Nameprovider>();
    return Column(
      children: [
        Text(
          provider.name,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        Text(
          provider.age,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
