import 'package:finance_app/models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthService extends ChangeNotifier {
  Box<UserModels>? _userBox;

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
        return user;
      }
    }
    return null;
  }
}
