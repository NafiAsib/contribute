import 'package:contribute/core/routes/route_generator.dart';
import 'package:contribute/presentation/screens/add_project/add_project_provider.dart';
// import 'package:contribute/presentation/screens/add_project/add_project_screen.dart';
import 'package:contribute/presentation/screens/home/home_screen.dart';
import 'package:contribute/presentation/screens/signin/signin_provider.dart';
// import 'package:contribute/presentation/screens/signin/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SigninProvider>(
          create: (_) => SigninProvider(),
        ),
        ChangeNotifierProvider<AddProjectProvider>(
          create: (_) => AddProjectProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Contr!bute',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: const Color(0xFFEEEEEE),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF00ADB5),
          ),
          primaryColor: const Color(0xFF393E46),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF00ADB5),
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            headline2: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              // fontWeight: FontWeight.w400,
            ),
            headline3: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            headline4: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
