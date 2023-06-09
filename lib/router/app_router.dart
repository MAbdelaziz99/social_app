import 'package:flutter/material.dart';
import 'package:social_app/presentation/home/home_screen.dart';
import 'package:social_app/presentation/likes/likes_screen.dart';
import 'package:social_app/presentation/register/register_screen.dart';
import 'package:social_app/presentation/search_for_users/search_for_users_screen.dart';
import 'package:social_app/presentation/splash/splash_screen.dart';
import 'package:social_app/router/router_const.dart';
import 'package:social_app/router/screen_arguments.dart';

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
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case searchForUsersScreen:
        return MaterialPageRoute(
          builder: (context) => const SearchForUsersScreen(),
        );
      case likesScreen:
        var args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (context) => LikesScreen(
            screenArguments: args,
          ),
        );
    }
    return null;
  }

  getMaterialPageRoute({required Widget widget}) => MaterialPageRoute(
        builder: (context) => widget,
      );
}
