import 'package:faith/colorapp.dart';
import 'package:faith/home_feature/presentation/provider/homeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dailycheckwidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final provider = context.watch<Homeprovider>();

    final bool isDone = provider.isCompleted(index);

    // First 5 = Fajr, Dhuhr, Asr, Maghrib, Isha
    final bool isPrayer = index <= 4;

    final bool isActive = isPrayer
        ? provider.isPrayerActive(prayerName)
        : true;

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () async {
        if (isDone) {
          return;
        }

        if (isPrayer && !isActive) {
          return;
        }

        await provider.toggleTask(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isDone
            ? lockcheck(width, height)
            : unlockcheck(
                width,
                height,
                isActive,
              ),
      ),
    );
  }

  // ============================================================
  // UNLOCK / NOT COMPLETED
  // ============================================================

  Widget unlockcheck(
    double width,
    double height,
    bool isActive,
  ) {
    return Container(
      width: width,
      height: height * 0.085,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? AppColors.emeraldGreen
              : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? AppColors.emeraldGreen
                    : Colors.grey.shade300,
                width: 2,
              ),
            ),
          ),

          const SizedBox(width: 15),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prayerName,
                style: TextStyle(
                  color: isActive
                      ? AppColors.black
                      : Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),

              Text(
                prayerTime,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const Spacer(),

          Icon(
            isActive
                ? Icons.chevron_right
                : Icons.lock_outline,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMPLETED
  // ============================================================

  Widget lockcheck(
    double width,
    double height,
  ) {
    return Container(
      width: width,
      height: height * 0.1,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.emeraldGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.emeraldGreen,
          width: 1,
        ),
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
            child: const Icon(
              Icons.check,
              size: 24,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 15),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prayerName,
                style: const TextStyle(
                  color: AppColors.emeraldGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              Text(
                prayerTime,
                style: const TextStyle(
                  color: AppColors.emeraldGreen,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
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
                Icon(
                  Icons.check,
                  size: 18,
                  color: AppColors.emeraldGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}