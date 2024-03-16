import 'package:flutter/material.dart';

class IntroProvider extends ChangeNotifier {
  String btnName = "Continue";

  void setName(String newname) {
    btnName = newname;
    notifyListeners();
  }
}
