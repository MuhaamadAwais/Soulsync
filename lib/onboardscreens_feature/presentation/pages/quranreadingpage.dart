
import 'package:faith/colorapp.dart';
import 'package:faith/onboardscreens_feature/presentation/pages/scorepage.dart';
import 'package:flutter/material.dart';

class Quranreadingpage extends StatefulWidget {
  const Quranreadingpage({super.key});

  @override
  State<Quranreadingpage> createState() => _QuranreadingpageState();
}

class _QuranreadingpageState extends State<Quranreadingpage>
    with TickerProviderStateMixin {
  int currentPage = 0;

  Widget buildDot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 18 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? AppColors.gold : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _slideanimationcontroller;
  late Animation<Offset> _slideanimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _animationController.forward();

    _slideanimationcontroller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideanimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _slideanimationcontroller,
            curve: Curves.bounceOut,
          ),
        );
    _slideanimationcontroller.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _slideanimationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width,
              height: MediaQuery.of(context).size.height * 0.42,
              color: AppColors.emeraldGreen,
              child: FadeTransition(
                opacity: _animation,
                child: Center(
                  child: Container(
                    width: width * 0.32,
                    height: width * 0.32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.25)),
                    ),
                    child: const Icon(
                      Icons.auto_stories,
                      size: 75,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // 🔷 BOTTOM SECTION
            Expanded(
              child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Quran Reading Progress",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SlideTransition(
                      position: _slideanimation,
                      child: Text(
                        "Log your daily Quran readin,track Juz completion, and build a consistent reading strak.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // 🔘 DOTS (dynamic)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildDot(false),
                        buildDot(true),
                        buildDot(false),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // 🔥 MODERN BUTTON
                    Center(
                      child: SafeArea(
                        top: false,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Scorepage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: width * 0.7,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              color: AppColors.emeraldGreen,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
