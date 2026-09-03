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

    // API sirf ek dafa call hogi
    prayerFuture = prayerService.getprayertime();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, Map<String, String>>>(
      future: prayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('No prayer times found'));
        }

        final prayerTimes = snapshot.data!;

        return Column(
          children: [
            Dailycheckwidget(
              index: 0,
              prayerName: 'Fajr',
              prayerTime:
                  '${prayerTimes['Fajr']!['start']} - '
                  '${prayerTimes['Fajr']!['end']}',
            ),

            Dailycheckwidget(
              index: 1,
              prayerName: 'Dhuhr',
              prayerTime:
                  '${prayerTimes['Dhuhr']!['start']} - '
                  '${prayerTimes['Dhuhr']!['end']}',
            ),

            Dailycheckwidget(
              index: 2,
              prayerName: 'Asr',
              prayerTime:
                  '${prayerTimes['Asr']!['start']} - '
                  '${prayerTimes['Asr']!['end']}',
            ),

            Dailycheckwidget(
              index: 3,
              prayerName: 'Maghrib',
              prayerTime:
                  '${prayerTimes['Maghrib']!['start']} - '
                  '${prayerTimes['Maghrib']!['end']}',
            ),

            Dailycheckwidget(
              index: 4,
              prayerName: 'Isha',
              prayerTime:
                  '${prayerTimes['Isha']!['start']} - '
                  '${prayerTimes['Isha']!['end']}',
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
