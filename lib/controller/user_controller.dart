import 'package:flutter/material.dart';
import 'package:geeksynergymovie/models/user_model.dart';
import 'package:hive/hive.dart';

class UserController extends ChangeNotifier {
  static const String userBoxName = 'userBox';
  Box? userBox;
  bool isLoggedIn = false;

  UserController() {
    _initializeHive(); // Initialize asynchronously
  }

  Future<void> _initializeHive() async {
    userBox = await Hive.openBox<UserModel>(userBoxName);
    checkLoginStatus();
    notifyListeners();
  }

  void signUp(UserModel user) async {
    // Ensure the userBox is initialized before trying to use it
    if (userBox == null) {
      await _initializeHive();
    }
    userBox!.put('user', user); // Save user to Hive
    isLoggedIn = true;
    notifyListeners();
  }

  void signOut() {
    isLoggedIn = false;
    notifyListeners();
  }

  void checkLoginStatus() {
    if (userBox != null) {
      isLoggedIn = userBox!.containsKey('user');
    }
    notifyListeners();
  }

  UserModel? getUser() {
    return userBox?.get('user');
  }
}
