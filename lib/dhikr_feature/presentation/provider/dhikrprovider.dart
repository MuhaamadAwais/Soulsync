import 'package:flutter/material.dart';

class Dhikrprovider extends ChangeNotifier {

  int counter = 0;
  int selectedIndex = 0;

  final List<int> targets = [33, 33, 34];

  final dhikrs = [
    {"arabic": "سُبْحَانَ اللَّه", "english": "SubhanAllah"},
    {"arabic": "الْحَمْدُ لِلَّه", "english": "Alhamdulillah"},
    {"arabic": "اللَّهُ أَكْبَر", "english": "Allahu Akbar"},
  ];

  int get target => targets[selectedIndex];

  double get progress => counter / target;

  void increment() {
    if (counter < target) {
      counter++;
      notifyListeners();
    }
  }

  void reset() {
    counter = 0;
    notifyListeners();
  }

  void changeDhikr(int index) {
    selectedIndex = index;
    counter = 0;
    notifyListeners();
  }
}