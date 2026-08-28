import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Nameprovider extends ChangeNotifier {
  String _name = "";

  String get name => _name;

  Future<void> loadname() async {
    final prefs = await SharedPreferences.getInstance();

    _name = prefs.getString("name") ?? "";

    notifyListeners();
  }

  Future<void> updateName(String newName) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", newName);

    _name = newName;

    notifyListeners();
  }
}