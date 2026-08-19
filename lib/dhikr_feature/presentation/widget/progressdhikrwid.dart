import 'package:faith/colorapp.dart';
import 'package:faith/dhikr_feature/presentation/provider/dhikrprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Progressdhikrwid extends StatelessWidget {
  const Progressdhikrwid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Dhikrprovider>(context);
    double width = MediaQuery.of(context).size.width;
    final Color progressColor = provider.counter >= provider.target
        ? AppColors.gold
        : AppColors.emeraldGreen;
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: width * 0.6,
            height: width * 0.6,
            child: CircularProgressIndicator(
              strokeWidth: 15,
              value: provider.progress,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation(progressColor),
            ),
          ),

          // Inner Circle
          SizedBox(
            width: width * 0.45,
            height: width * 0.45,
            child: CircularProgressIndicator(
              strokeWidth: 10,
              value: provider.progress,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation(progressColor),
            ),
          ),

          // Center Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${provider.counter}",
                style: TextStyle(
                  color: progressColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Text(
                "/${provider.target}",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
