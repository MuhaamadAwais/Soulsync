import 'package:flutter/material.dart';

class Profileselectprovider extends ChangeNotifier {
  int selectedIndex=0;
  void goals(int index){
    selectedIndex=index;
    notifyListeners();
  }
}
