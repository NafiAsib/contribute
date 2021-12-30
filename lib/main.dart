import 'package:contribute/core/routes/route_generator.dart';
import 'package:contribute/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contr!bute',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
