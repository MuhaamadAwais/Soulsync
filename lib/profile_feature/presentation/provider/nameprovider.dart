import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Nameprovider extends ChangeNotifier {
  String _name = "";
  String _age = "";

  String get name => _name;
  String get age => _age;

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    _name = prefs.getString("name") ?? "";
    _age = prefs.getString("age") ?? "";

    notifyListeners();
  }

  Future<void> updateName(String newName) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", newName);

    _name = newName;

    notifyListeners();
  }

  Future<void> updateAge(String newAge) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("age", newAge);

    _age = newAge;

    notifyListeners();
  }
}