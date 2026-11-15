import 'package:faith/colorapp.dart';
import 'package:faith/progress_feature/presentation/provider/progressprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counttotalwid extends StatelessWidget {
  const Counttotalwid({super.key});

  @override
  Widget build(BuildContext context) {
    final progresspro = Provider.of<Progressprovider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: totalcounts(
              Icons.mosque,
              progresspro.totalPrayers.toString(),
              "Total Salah",
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: totalcounts(
              Icons.auto_stories,
              progresspro.quranDays.toString(),
              "Quran Days",
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: totalcounts(
              Icons.menu_book,
              progresspro.dhikrDays.toString(),
              "Dhikr Days",
            ),
          ),
        ],
      ),
    );
  }

  Widget totalcounts(IconData iconss, String totalcount, String nametitle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconss, size: 24, color: AppColors.emeraldGreen),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              totalcount,
              style: TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              nametitle,
              maxLines: 1,
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}