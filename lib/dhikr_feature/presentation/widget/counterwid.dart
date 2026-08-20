
import 'package:faith/colorapp.dart';
import 'package:faith/dhikr_feature/presentation/provider/dhikrprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counterwid extends StatelessWidget {

  const Counterwid({super.key, });

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<Dhikrprovider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            provider.increment();
          },
          child: Container(
            width: width * 0.55,
            height: height * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.emeraldGreen,
            ),
            child: Center(
              child: Text(
                "+1",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: width * 0.035),
        GestureDetector(
          onTap: () {
            provider.reset();
          },
          child: Container(
            width: width * 0.15,
            height: height * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Center(child: Icon(Icons.recycling, color: AppColors.black)),
          ),
        ),
      ],
    );
  }
}
