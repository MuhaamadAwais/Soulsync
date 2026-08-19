
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              provider.increment();
            },
            child: Container(
              width: width * 0.7,
              height: height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.emeraldGreen,
              ),
              child: Center(
                child: Text(
                  "+1",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: width * 0.055),
          GestureDetector(
            onTap: () {
              provider.reset();
            },
            child: Container(
              width: width * 0.2,
              height: height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Center(child: Icon(Icons.recycling, color: AppColors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
