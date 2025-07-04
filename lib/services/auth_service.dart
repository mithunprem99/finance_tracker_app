import 'package:finance_app/models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  Box<UserModels>? _userBox;
  static const String _loggedInKey = '_isLoggedIn';
  Future<void> openBox() async {
    if (!Hive.isBoxOpen('user')) {
      _userBox = await Hive.openBox<UserModels>('user');
    } else {
      _userBox = Hive.box<UserModels>('user');
    }
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
        await setLoggedInState(true, user.id);
        return user;
      }
    }
    return null;
  }

  Future<void> setLoggedInState(bool isLoggedIn, String id) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_loggedInKey, isLoggedIn);
    await pref.setString('id', id);
  }

  Future<bool> isUserLoggedIN() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_loggedInKey) ?? false;
  }

  Future<UserModels?> getCurrentUser() async {
    final isCurrentUsr = await isUserLoggedIN();
    if (_userBox == null || !_userBox!.isOpen) {
      await openBox();
    }

    if (isCurrentUsr) {
      final id = await getCurrentUserID();
      for (var user in _userBox!.values) {
        print("Checking user with id: ${user.id}");
        if (user.id == id) {
          print("✅ Found userId: ${user.id}");
          return user;
        }
      }
    }
    print("❌ No matching user found");
    return null;
  }

  Future<String?> getCurrentUserID() async {
    final prefs = await SharedPreferences.getInstance();
    final id = await prefs.getString('id');
    return id;
  }

Future<void> logOut() async {
  Box settingsBox = await Hive.openBox('settings');
  await settingsBox.put('isLoggedIn', false);
  notifyListeners();
}

}
