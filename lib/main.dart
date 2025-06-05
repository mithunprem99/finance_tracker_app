import 'package:finance_app/constants/colors.dart';
import 'package:finance_app/models/user_models.dart';
import 'package:finance_app/screens/home.dart';
import 'package:finance_app/screens/login.dart';
import 'package:finance_app/screens/register.dart';
import 'package:finance_app/screens/splash_screen.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelsAdapter());
  await AuthService().openBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            displaySmall: TextStyle(color: Colors.white, fontSize: 17),
          ),
          scaffoldBackgroundColor: ScaffoldColor,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          'login': (context) => const Login(),
          'register': (context) => const Register(),
          'home': (context) => const Home(),

        },
      ),
    );
  }
}
