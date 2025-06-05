import 'package:finance_app/constants/colors.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkloginState();
    super.initState();
  }

  Future<void> checkloginState() async {
    await Future.delayed(Duration(seconds: 5));
    final authService = Provider.of<AuthService>(context, listen: false);

    final islogin = await authService.isUserLoggedIN();

    if (islogin == true) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SplashColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset('assets/images/logo.png')],
          ),
        ),
      ),
    );
  }
}
