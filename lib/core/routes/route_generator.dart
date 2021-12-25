import 'package:contribute/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Something is wrong with routing!!'),
        ),
      );
    });
  }
}
