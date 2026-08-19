import 'package:flutter/material.dart';
class Homeprovider extends ChangeNotifier {
  List<bool> completeed=[
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

void toggleTask(int index){
  completeed[index]=!completeed[index];
  notifyListeners();
}


int get CompletedCount{
  return completeed.where((element) => element,).length;
}

double get score{
  return (CompletedCount / completeed.length)*100;
}
}
