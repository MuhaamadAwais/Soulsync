import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Hadingtextwidget extends StatelessWidget {
  const Hadingtextwidget({super.key});

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('EEEE ,MMMM d').format(DateTime.now());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date, style: TextStyle(color: Colors.white70, fontSize: 14)),
          Text(
            "Assalamu Alaikum",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          Text(
            "Awais",
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
