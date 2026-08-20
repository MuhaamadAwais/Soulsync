import 'package:faith/colorapp.dart';
import 'package:faith/dhikr_feature/presentation/provider/dhikrprovider.dart';
import 'package:faith/dhikr_feature/presentation/widget/counterwid.dart';
import 'package:faith/dhikr_feature/presentation/widget/dhikrcompletewid.dart';
import 'package:faith/dhikr_feature/presentation/widget/dhikrnamewid.dart';
import 'package:faith/dhikr_feature/presentation/widget/headingwid.dart';
import 'package:faith/dhikr_feature/presentation/widget/progressdhikrwid.dart';
import 'package:faith/dhikr_feature/presentation/widget/selectitemwid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dhikrpage extends StatefulWidget {
  const Dhikrpage({super.key});

  @override
  State<Dhikrpage> createState() => _DhikrpageState();
}

class _DhikrpageState extends State<Dhikrpage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0.2), // niche se start
          end: Offset.zero, // original position
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Dhikrprovider>(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Headingwid(),
              SizedBox(height: height * 0.03),
              Selectitemwid(
                selectedIndex: provider.selectedIndex,
                onTab: (index) {
                  provider.changeDhikr(index);
                  _animationController.reset();
                  _animationController.forward();
                },
              ),
              SizedBox(height: height * 0.03),
              Center(
                child: Dhikrnamewid(
                  arabic: provider.dhikrs[provider.selectedIndex]['arabic']!,
                  english: provider.dhikrs[provider.selectedIndex]['english']!,
                  fadeanimation: _fadeAnimation,
                  slideAnimation: _slideAnimation,
                ),
              ),
              SizedBox(height: height * 0.03),
              Progressdhikrwid(),
              SizedBox(height: height * 0.04),
              Counterwid(),
              SizedBox(height: height * 0.02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Daily Checklist",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              Dhikrcompletewid(
                selectedIndex: provider.selectedIndex,
                onTap: (index) {
                  provider.changeDhikr(index);
                  _animationController.reset();
                  _animationController.forward();
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
