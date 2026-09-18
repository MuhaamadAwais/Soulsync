import 'package:faith/home_feature/presentation/provider/homeprovider.dart';
import 'package:faith/home_feature/presentation/widget/dailycheckwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dailychecklist extends StatelessWidget {
  const Dailychecklist({super.key});
  TimeOfDay parseApiTime(String time) {
    final parts = time.split(':');

    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return TimeOfDay(
      hour: hour,
      minute: minute,
    );
  }

  String formatPrayerTime(
    BuildContext context,
    String time,
  ) {
    final timeOfDay = parseApiTime(time);

    return timeOfDay.format(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Homeprovider>();

    final prayerTimes = provider.prayerTimes;

    // Agar prayer times abhi API se load nahi hue
    if (prayerTimes.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Dailycheckwidget(
          index: 0,
          prayerName: 'Fajr',
          prayerTime:
              '${formatPrayerTime(context, prayerTimes['Fajr']!['start']!)} - '
              '${formatPrayerTime(context, prayerTimes['Fajr']!['end']!)}',
        ),

        Dailycheckwidget(
          index: 1,
          prayerName: 'Dhuhr',
          prayerTime:
              '${formatPrayerTime(context, prayerTimes['Dhuhr']!['start']!)} - '
              '${formatPrayerTime(context, prayerTimes['Dhuhr']!['end']!)}',
        ),

        Dailycheckwidget(
          index: 2,
          prayerName: 'Asr',
          prayerTime:
              '${formatPrayerTime(context, prayerTimes['Asr']!['start']!)} - '
              '${formatPrayerTime(context, prayerTimes['Asr']!['end']!)}',
        ),

        Dailycheckwidget(
          index: 3,
          prayerName: 'Maghrib',
          prayerTime:
              '${formatPrayerTime(context, prayerTimes['Maghrib']!['start']!)} - '
              '${formatPrayerTime(context, prayerTimes['Maghrib']!['end']!)}',
        ),

        Dailycheckwidget(
          index: 4,
          prayerName: 'Isha',
          prayerTime:
              '${formatPrayerTime(context, prayerTimes['Isha']!['start']!)} - '
              '${formatPrayerTime(context, prayerTimes['Isha']!['end']!)}',
        ),

        Dailycheckwidget(
          index: 5,
          prayerName: 'Quran',
          prayerTime: 'Daily',
        ),

        Dailycheckwidget(
          index: 6,
          prayerName: 'Dhikr',
          prayerTime: 'Daily',
        ),
      ],
    );
  }
}