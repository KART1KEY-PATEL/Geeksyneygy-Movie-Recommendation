// providers.dart
import 'package:geeksynergymovie/auth_state.dart';
import 'package:geeksynergymovie/controller/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter/widgets.dart';

List<SingleChildWidget> appProviders() {
  return [
    ChangeNotifierProvider(create: (_) => UserController()),
    ChangeNotifierProvider(create: (_) => AuthState()),

  ];
}
