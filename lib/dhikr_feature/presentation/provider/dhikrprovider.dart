import 'package:flutter/material.dart';

class Dhikrprovider extends ChangeNotifier {
  int counter = 0;
  int selectedIndex = 0;

  bool showCompletionAnimation = false;
  bool isCompleting = false;

  final List<int> targets = [33, 33, 34];

  final dhikrs = [
    {
      "arabic": "سُبْحَانَ اللَّه",
      "english": "SubhanAllah",
    },
    {
      "arabic": "الْحَمْدُ لِلَّه",
      "english": "Alhamdulillah",
    },
    {
      "arabic": "اللَّهُ أَكْبَر",
      "english": "Allahu Akbar",
    },
  ];

  int get target => targets[selectedIndex];

  double get progress => counter / target;

  String get currentDhikr => dhikrs[selectedIndex]["english"]!;

  String get currentArabic => dhikrs[selectedIndex]["arabic"]!;

  // Gold when current Dhikr is complete
  bool get isComplete => counter >= target;

  void increment() {
    // Don't allow tapping while waiting 1 second
    if (isCompleting || showCompletionAnimation) {
      return;
    }

    if (counter < target) {
      counter++;
      notifyListeners();

      // Target reached
      if (counter == target) {
        _handleCompletion();
      }
    }
  }

  Future<void> _handleCompletion() async {
    isCompleting = true;
    notifyListeners();

    // Keep completed progress GOLD for 1 second
    await Future.delayed(const Duration(milliseconds: 600));

    // If Allahu Akbar is completed
    if (selectedIndex == dhikrs.length - 1) {
      isCompleting = false;
      showCompletionAnimation = true;
      notifyListeners();
      return;
    }

    // Move to next Dhikr
    selectedIndex++;
    counter = 0;
    isCompleting = false;

    notifyListeners();
  }

  void finishAnimation() {
    showCompletionAnimation = false;
    notifyListeners();
  }

  void reset() {
    counter = 0;
    selectedIndex = 0;
    isCompleting = false;
    showCompletionAnimation = false;

    notifyListeners();
  }

  void changeDhikr(int index) {
    if (index >= 0 && index < dhikrs.length) {
      selectedIndex = index;
      counter = 0;
      isCompleting = false;
      showCompletionAnimation = false;

      notifyListeners();
    }
  }
}