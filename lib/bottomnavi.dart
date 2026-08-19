import 'package:faith/colorapp.dart';
import 'package:faith/dhikr_feature/presentation/page/dhikrpage.dart';
import 'package:faith/home_feature/presentation/page/homepage.dart';
import 'package:faith/profile_feature/presentation/pages/profilepagemain.dart';
import 'package:faith/progress_feature/presentation/page/progresspage.dart';
import 'package:flutter/material.dart';

class Bottomnavi extends StatefulWidget {
  const Bottomnavi({super.key});

  @override
  State<Bottomnavi> createState() => _BottomnaviState();
}

class _BottomnaviState extends State<Bottomnavi> {
  int currentIndex = 0;

  final List<Widget> pages = [
    Homepage(),
    Progresspage(),
    Dhikrpage(),
    Profilepagemain(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildItem(Icons.home,Icons.home_outlined, "Home", 0),
              buildItem(Icons.trending_up, Icons.trending_up_outlined,"Progress", 1),
              buildItem(Icons.menu_book,Icons.menu_book_outlined ,"Dhikr", 2),
              buildItem(Icons.account_circle, Icons.account_circle_outlined,"profile", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(
    IconData selectedIcon,
    IconData unselectedIcon,
    String label,
    int index,
  ) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.emeraldGreen.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: AppColors.emeraldGreen) : null,
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              color: isSelected ? AppColors.emeraldGreen : AppColors.gold,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.emeraldGreen,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
