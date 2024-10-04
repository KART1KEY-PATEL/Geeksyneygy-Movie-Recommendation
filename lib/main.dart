import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geeksynergymovie/app_routes.dart';
import 'package:geeksynergymovie/app_theme.dart';
import 'package:geeksynergymovie/auth_state.dart';
import 'package:geeksynergymovie/models/user_model.dart';
import 'package:geeksynergymovie/models/user_status_model.dart';
import 'package:geeksynergymovie/pages/home/home_page.dart';
import 'package:geeksynergymovie/pages/onboarding/signup_page.dart';
import 'package:geeksynergymovie/providers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Disable App Check when running in the emulator
  // _disableAppCheckForEmulator();

  // Initialize Hive and open boxes
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('userBox');
  Hive.registerAdapter(UserStatusModelAdapter());


  // Ensure the app runs in portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // // Check if running in debug mode (or in your case, emulator)
  // if (const bool.fromEnvironment('dart.vm.product') == false) {
  //   _connectToFirebaseEmulator(); // Connect to the local emulator
  // }

  runApp(
    MultiProvider(
      providers: appProviders(),
      child: DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: false);

    // Check the login status when the app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authState.checkLoginStatus();
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),
      home: Consumer<AuthState>(
        builder: (context, authState, _) {
          if (authState.isLoggedIn) {
            if (authState.isOnboardingCompleted) {
              return HomePage(); // Main landing page
            } else {
              return HomePage(); // Redirect to onboarding if not completed
            }
          } else {
            return SignUpPage(); // Redirect to login if not logged in
          }
        },
      ),
      routes: appRoutes,
    );
  }
}
