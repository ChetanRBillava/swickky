import 'package:flutter/material.dart';
import 'package:swickky/presentation/screens/home_screen.dart';

import '../../core/exceptions/route_exception.dart';
import '../screens/splash_screen.dart';

class AppRouter {
  static const String splash = '/',
      home = 'home';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}