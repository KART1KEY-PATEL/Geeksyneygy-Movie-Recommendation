import 'package:flutter/material.dart';
import 'package:geeksynergymovie/models/user_status_model.dart';
import 'package:hive/hive.dart';

class AuthState extends ChangeNotifier {
  Box<UserStatusModel>? userStatusBox;

  bool _isLoggedIn = false;
  bool _isOnboardingCompleted = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get isOnboardingCompleted => _isOnboardingCompleted;

  AuthState() {
    _initializeUserStatus();
  }

  Future<void> _initializeUserStatus() async {
    userStatusBox = await Hive.openBox<UserStatusModel>('userStatusBox');
    checkLoginStatus();
  }

  void checkLoginStatus() {
    if (userStatusBox != null && userStatusBox!.isNotEmpty) {
      _isLoggedIn = userStatusBox!.get('status')?.isLoggedIn ?? false;
    }
    notifyListeners();
  }

  void login() {
    if (userStatusBox != null) {
      userStatusBox!.put('status', UserStatusModel(isLoggedIn: true));
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  void logout() {
    if (userStatusBox != null) {
      userStatusBox!.put('status', UserStatusModel(isLoggedIn: false));
      _isLoggedIn = false;
      notifyListeners();
    }
  }

  void completeOnboarding() {
    _isOnboardingCompleted = true;
    notifyListeners();
  }
}