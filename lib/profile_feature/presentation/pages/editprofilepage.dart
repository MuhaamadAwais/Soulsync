import 'package:faith/colorapp.dart';
import 'package:faith/profile_feature/presentation/widget/inputfielsdwid.dart';
import 'package:faith/profile_feature/presentation/widget/maineditwid.dart';
import 'package:flutter/material.dart';

class Editprofilepage extends StatefulWidget {
  const Editprofilepage({super.key});

  @override
  State<Editprofilepage> createState() => _EditprofilepageState();
}

class _EditprofilepageState extends State<Editprofilepage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Maineditwid(),
              SizedBox(height: height * 0.02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "PERSONAL INFORMATION",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),

              Inputfielsdwid(),
            ],
          ),
        ),
      ),
    );
  }
}
