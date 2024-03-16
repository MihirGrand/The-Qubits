import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  double progress1 = 0.0;
  double progress2 = 0.0;
  double progress3 = 0.0;

  void updateProgresses(double one, double two, double three) {
    progress1 = one;
    progress2 = two;
    progress3 = three;
    notifyListeners();
  }

  void updateProgress1(double one) {
    progress1 = one;
    notifyListeners();
  }

  void updateProgress2(double two) {
    progress2 = two;
    notifyListeners();
  }

  void updateProgress3(double three) {
    progress3 = three;
    notifyListeners();
  }
}
