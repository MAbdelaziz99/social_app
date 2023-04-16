import 'package:flutter/material.dart';
import 'package:social_app/presentation/register/register_screen.dart';
import 'package:social_app/presentation/splash/splash_screen.dart';
import 'package:social_app/router/router_const.dart';

import '../presentation/login/login_screen.dart';

class AppRouter {
  static AppRouter get() => AppRouter();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case registerScreen:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
    }
    return null;
  }

  getMaterialPageRoute({required Widget widget}) => MaterialPageRoute(
        builder: (context) => widget,
      );
}
