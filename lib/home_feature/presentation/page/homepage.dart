import 'package:faith/colorapp.dart';
import 'package:faith/home_feature/presentation/provider/homeprovider.dart';
import 'package:faith/home_feature/presentation/widget/dailycheckwidget.dart';
import 'package:faith/home_feature/presentation/widget/dailyhikrwid.dart';
import 'package:faith/home_feature/presentation/widget/hadingtextwidget.dart';
import 'package:faith/home_feature/presentation/widget/scorewidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, String>> prayers = [
    {"name": "Fajr", "time": "5:32 AM"},
    {"name": "Dhuhr", "time": "12:30 PM"},
    {"name": "Asr", "time": "4:15 PM"},
    {"name": "Maghrib", "time": "6:55 PM"},
    {"name": "Isha", "time": "8:20 PM"},
    {"name": "Quran Reading", "time": "Daily"},
    {"name": "Daily Dhikr", "time": "Daily"},
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Homeprovider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                height: height * 0.43,
                color: AppColors.emeraldGreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 05,),
                    Hadingtextwidget(),
                    Scorewidget(
                      score: provider.score,
                      CompletedCount: provider.CompletedCount,
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: width,
                color: Colors.grey.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Daily Dhikr",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    Dailyhikrwid(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Daily Checklist",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: prayers.length,
                      itemBuilder: (context, index) {
                        return Dailycheckwidget(
                          prayerName: prayers[index]["name"]!,
                          prayerTime: prayers[index]["time"]!,
                          index: index,
                        );
                      },
                    ),

                    SizedBox(height: height * 0.05),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
