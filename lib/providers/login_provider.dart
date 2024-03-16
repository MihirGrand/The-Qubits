import 'package:dedsec/classes/user.dart';
import 'package:dedsec/classes/userHouse.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  User? user;
  List<UserHouse>? homes;

  void setUser(User neww) {
    user = neww;
    notifyListeners();
  }

  void setHomes(List<UserHouse> housess) {
    homes = housess;
    notifyListeners();
  }
}
