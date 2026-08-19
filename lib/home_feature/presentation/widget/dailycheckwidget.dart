
import 'package:faith/colorapp.dart';
import 'package:faith/home_feature/presentation/provider/homeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dailycheckwidget extends StatefulWidget {
  final int index;
  final String prayerName;
  final String prayerTime;

  const Dailycheckwidget({
    super.key,
    required this.index,
    required this.prayerName,
    required this.prayerTime,
  });

  @override
  State<Dailycheckwidget> createState() => _DailycheckwidgetState();
}

class _DailycheckwidgetState extends State<Dailycheckwidget> {

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<Homeprovider>(context);
    bool isDone=provider.completeed[widget.index];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
       provider.toggleTask(widget.index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isDone
            ? doneContainer(width, height)
            : normalContainer(width, height),
      ),
    );
  }

  Widget normalContainer(double width, double height) {
    return Container(
      width: width,
      height: height * 0.085,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 3),
            ),
          ),

          const SizedBox(width: 15),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.prayerName,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),

              Text(
                widget.prayerTime,
                style: const TextStyle(color: Colors.grey, fontSize: 14,fontWeight: FontWeight.w400),
              ),
            ],
          ),

          const Spacer(),

          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget doneContainer(double width, double height) {
    return Container(
      width: width,
      height: height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.emeraldGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.emeraldGreen, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.emeraldGreen,
            ),
            child: const Icon(Icons.check, size: 24, color: Colors.white),
          ),

          const SizedBox(width: 15),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.prayerName,
                style: const TextStyle(
                  color: AppColors.emeraldGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              Text(
                widget.prayerTime,
                style: const TextStyle(
                  color: AppColors.emeraldGreen,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.emeraldGreen.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Done",
                  style: TextStyle(
                    color: AppColors.emeraldGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.check, size: 18, color: AppColors.emeraldGreen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
