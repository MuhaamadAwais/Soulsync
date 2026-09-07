import 'package:faith/colorapp.dart';
import 'package:faith/profile_feature/presentation/provider/nameprovider.dart';
import 'package:faith/profile_feature/presentation/widget/accountwid.dart';
import 'package:faith/profile_feature/presentation/widget/logoutwid.dart';
import 'package:faith/profile_feature/presentation/widget/namewid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profilepagemain extends StatelessWidget {
  const Profilepagemain({super.key});
  @override
  Widget build(BuildContext context) {
    final name = context.watch<Nameprovider>().name;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width,
                    height: height * 0.25,
                    color: AppColors.emeraldGreen,
                  ),

                  Positioned(
                    bottom: -35,
                    child: Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        border: Border.all(
                          color: AppColors.emeraldGreen,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.emeraldGreen,
                          ),
                          child: Center(
                            child: Text(
                              name.isNotEmpty ? name[0] : "",
                              style: TextStyle(
                                fontSize: 30,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Center(child: Namewid()),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 16),
                child: Text(
                  "Account",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              Accountwid(),
              SizedBox(height: height * 0.02),

              Center(child: Logoutwid()),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
