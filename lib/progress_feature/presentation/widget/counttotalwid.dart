import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Counttotalwid extends StatelessWidget {
  const Counttotalwid({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        totalcounts(
          width * 0.25,
          height * 0.15,
          Icons.mosque,
          "127",
          "Total Salah",
        ),

        totalcounts(
          width * 0.25,
          height * 0.15,
          Icons.auto_stories,
          "18",
          "Quran Days",
        ),

        totalcounts(
          width * 0.25,
          height * 0.15,
          Icons.menu_book,
          "23",
          "Dhikr Days",
        ),
      ],
    );
  }

  Widget totalcounts(
    double width,
    double height,
    IconData iconss,
    String totalcount,
    String nametitle,
  ) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconss, size: 24, color: AppColors.emeraldGreen),
          Text(
            totalcount,
            style: TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          Text(
            nametitle,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
