import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Dhikrcompletewid extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;

  const Dhikrcompletewid({super.key, required this.selectedIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        buildItem(0, 33, "Subhan Allah", "سُبْحَانَ اللَّه", 33, width, height),
        buildItem(
          1,
          33,
          "Alhamdulillah",
          "الْحَمْدُ لِلَّه",
          33,
          width,
          height,
        ),
        buildItem(2, 34, "Allahu Akbar", "اللَّهُ أَكْبَر", 33, width, height),
      ],
    );
  }

  Widget buildItem(
    int index,
    int count,
    String engtext,
    String urdutext,
    int amount,
    double width,
    double height,
  ) {
    bool isCompleted = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        onTap?.call(index); // 🔥 important
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width,
          height: height * 0.12,
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColors.emeraldGreen.withOpacity(0.2)
                : AppColors.white,
            border: Border.all(
              color: isCompleted
                  ? AppColors.emeraldGreen
                  : Colors.grey.shade300,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$engtext",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),

                    Text(
                      "$urdutext",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: width * 0.2,
                  height: height * 0.075,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.emeraldGreen.withOpacity(0.2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$count",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),

                      Text(
                        "x",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
