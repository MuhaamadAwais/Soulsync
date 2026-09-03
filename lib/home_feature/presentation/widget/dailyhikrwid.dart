import 'package:faith/colorapp.dart';
import 'package:faith/home_feature/presentation/services/quranayatservice.dart';
import 'package:flutter/material.dart';

class Dailyhikrwid extends StatefulWidget {
  const Dailyhikrwid({super.key});

  @override
  State<Dailyhikrwid> createState() => _DailyhikrwidState();
}

class _DailyhikrwidState extends State<Dailyhikrwid> {
  final QuranService quranService = QuranService();
  late Future<Map<String, String>> ayahfuture;
  @override
  void initState() {
    super.initState();
    ayahfuture = quranService.getDailyAyah();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ayahfuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final arabic = snapshot.data!['arabic'] ?? '';
        final urdu = snapshot.data!['urdu'] ?? '';
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                arabic,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 22,
                  height: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                urdu,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.8,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
