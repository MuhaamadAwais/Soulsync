
import 'package:faith/colorapp.dart';
import 'package:faith/progress_feature/presentation/provider/progressprovider.dart';
import 'package:faith/progress_feature/presentation/widget/achievementwid.dart';
import 'package:faith/progress_feature/presentation/widget/counttotalwid.dart';
import 'package:faith/progress_feature/presentation/widget/maincontiwidprogess.dart';
import 'package:faith/progress_feature/presentation/widget/steekwidprogess.dart';
import 'package:faith/progress_feature/presentation/widget/weeklyaverageprogress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Progresspage extends StatefulWidget {
  const Progresspage({super.key});

  @override
  State<Progresspage> createState() => _ProgresspageState();
}

class _ProgresspageState extends State<Progresspage> {
  final achievements = [
    {"title": "3 Day Streak", "subtitle": "Completed Salah for 3 days"},
    {"title": "7 Day Streak", "subtitle": "Completed Salah for 7 days"},
    {"title": "15 Day Streak", "subtitle": "Completed Salah for 15 days"},
    {"title": "30 Day Streak", "subtitle": "Completed Salah for 30 days"},
  ];
  @override
  Widget build(BuildContext context) {
    final providerpro = Provider.of<Progressprovider>(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Maincontiwidprogess(),
              SizedBox(height: height * 0.02),
              Steekwidprogess(
                currentStreak: providerpro.currentStreak,
                bestStreak: providerpro.bestStreak,
              ),
              Weeklyaverageprogress(),
              SizedBox(height: height * 0.02),
              Counttotalwid(),
              SizedBox(height: height * 0.01),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Achievements",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              ListView.builder(
                itemCount: providerpro.achievements.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Achievementwid(
                    streakname: providerpro.achievements[index]['title']!,
                    titlename: providerpro.achievements[index]["subtitle"]!,
                  );
                },
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
