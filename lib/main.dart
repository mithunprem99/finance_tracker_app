import 'package:finance_app/constants/colors.dart';
import 'package:finance_app/screens/login.dart';
import 'package:finance_app/screens/register.dart';
import 'package:finance_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(displaySmall: TextStyle(color: Colors.white,fontSize: 17)),
        scaffoldBackgroundColor: ScaffoldColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        'login': (context) => const Login(),
        'register':(context) => const Register(),
      },
    );
  }
}
