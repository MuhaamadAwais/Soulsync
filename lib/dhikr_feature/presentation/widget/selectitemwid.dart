import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Selectitemwid extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTab;
  const Selectitemwid({
    super.key,
    required this.selectedIndex,
    required this.onTab,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildItem(0, "Subhan Allah", width * 0.3, height * 0.055),
        buildItem(1, "Alhamdu lillah", width * 0.3, height * 0.055),
        buildItem(2, "Allahu Akbar", width * 0.3, height * 0.055),
      ],
    );
  }

  Widget buildItem(int index, String name, double width, double height) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTab(index),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.emeraldGreen : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.emeraldGreen : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }}