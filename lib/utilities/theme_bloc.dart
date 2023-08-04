// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';

class ThemeCubit extends ChangeNotifier {
  bool _state = false;

  bool get state => _state;

  void toggleTheme() {
    _state = !_state;
    notifyListeners();
  }
}
