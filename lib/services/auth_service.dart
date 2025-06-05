import 'package:finance_app/models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  Box<UserModels>? _userBox;
  static const String _loggedInKey = '_isLoggedIn';
  Future<void> openBox() async {
    _userBox = await Hive.openBox('user');
  }

  Future<bool> registerUser(UserModels user) async {
    if (_userBox == null) {
      await openBox();
    }
    await _userBox!.add(user);
    notifyListeners();
    print("success");
    return true;
  }

  Future<UserModels?> loginUser(String email, String password) async {
    if (_userBox == null) {
      await openBox();
    }

    for (var user in _userBox!.values) {
      if (user.email == email && user.password == password) {
        await setLoggedInState(true);
        return user;
      }
    }
    return null;
  }

  Future<void> setLoggedInState(bool isLoggedIn) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_loggedInKey, isLoggedIn);
  }

  Future <bool> isUserLoggedIN() async{
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_loggedInKey)?? false;
  }
}
