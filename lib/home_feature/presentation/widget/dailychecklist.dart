import 'package:faith/home_feature/presentation/services/payertimeservice.dart';
import 'package:faith/home_feature/presentation/widget/dailycheckwidget.dart';
import 'package:flutter/material.dart';

class Dailychecklist extends StatefulWidget {
  const Dailychecklist({super.key});

  @override
  State<Dailychecklist> createState() => _DailychecklistState();
}

class _DailychecklistState extends State<Dailychecklist> {
  final Payertimeservice prayerService = Payertimeservice();

  late Future<Map<String, Map<String, String>>> prayerFuture;

  @override
  void initState() {
    super.initState();

    prayerFuture = prayerService.getprayertime();
  }

  // API ke 24-hour time ko TimeOfDay mein convert karega
  TimeOfDay parseApiTime(String time) {
    final parts = time.split(':');

    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return TimeOfDay(
      hour: hour,
      minute: minute,
    );
  }

  // API ke start aur end time ko display format mein karega
  String formatPrayerTime(String time) {
    final timeOfDay = parseApiTime(time);

    return timeOfDay.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, Map<String, String>>>(
      future: prayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('No prayer times found'),
          );
        }

        final prayerTimes = snapshot.data!;

        return Column(
          children: [
            Dailycheckwidget(
              index: 0,
              prayerName: 'Fajr',
              prayerTime:
                  '${formatPrayerTime(prayerTimes['Fajr']!['start']!)} - '
                  '${formatPrayerTime(prayerTimes['Fajr']!['end']!)}',
            ),

            Dailycheckwidget(
              index: 1,
              prayerName: 'Dhuhr',
              prayerTime:
                  '${formatPrayerTime(prayerTimes['Dhuhr']!['start']!)} - '
                  '${formatPrayerTime(prayerTimes['Dhuhr']!['end']!)}',
            ),

            Dailycheckwidget(
              index: 2,
              prayerName: 'Asr',
              prayerTime:
                  '${formatPrayerTime(prayerTimes['Asr']!['start']!)} - '
                  '${formatPrayerTime(prayerTimes['Asr']!['end']!)}',
            ),

            Dailycheckwidget(
              index: 3,
              prayerName: 'Maghrib',
              prayerTime:
                  '${formatPrayerTime(prayerTimes['Maghrib']!['start']!)} - '
                  '${formatPrayerTime(prayerTimes['Maghrib']!['end']!)}',
            ),

            Dailycheckwidget(
              index: 4,
              prayerName: 'Isha',
              prayerTime:
                  '${formatPrayerTime(prayerTimes['Isha']!['start']!)} - '
                  '${formatPrayerTime(prayerTimes['Isha']!['end']!)}',
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
      },
    );
  }
}