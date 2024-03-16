import 'package:flutter/material.dart';

class RoomProvider extends ChangeNotifier {
  int index = 0;

  void setIndex(int newindex) {
    index = newindex;
    notifyListeners();
  }
}
