import 'package:contribute/presentation/screens/add_project/add_project_screen.dart';
import 'package:contribute/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:contribute/presentation/screens/home/home_screen.dart';
import 'package:contribute/presentation/screens/signin/signin_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case '/add-project':
        return MaterialPageRoute(builder: (_) => const AddProjectScreen());
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
