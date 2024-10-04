// app_routes.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geeksynergymovie/pages/home/home_page.dart';
import 'package:geeksynergymovie/pages/onboarding/signin_page.dart';
import 'package:geeksynergymovie/pages/onboarding/signup_page.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/signUpPage': (context) => SignUpPage(),
  '/homePage': (context) => HomePage(),
  '/signinPage': (context) => SigninPage(),
};
