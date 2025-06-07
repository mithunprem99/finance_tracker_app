import 'package:finance_app/services/auth_service.dart';
import 'package:finance_app/widgets/custom_button.dart';
import 'package:finance_app/widgets/custom_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 170, height: 170),
              SizedBox(height: 20),
              CustomTextFormFields(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter the email";
                  }
                  if (!value.contains('@gmail.com')) {
                    return 'Enter the correct email format';
                  }
                },
                textEditingController: _emailController,
                hintText: "Enter your Email",
                isPassword: false,
                obscureText: false,
              ),
              SizedBox(height: 20),
              CustomTextFormFields(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the password';
                  }
                  if (value.length <= 6) {
                    return 'Enter the password with minimum length of 6';
                  }
                },
                textEditingController: _passwordController,
                hintText: "Enter the password",
                obscureText: true,
                isPassword: true,
              ),
              SizedBox(height: 30),
              CustomButton(
                onPressed: () async {
                  if (_loginKey.currentState!.validate()) {
                    //login logic
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );
                    final res = await authService.loginUser(
                      _emailController.text.trim(),
                      _passwordController.text,
                    );
                    Navigator.pop(context);
                    if (res != null) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'home',
                        (route) => false,
                        arguments: res,
                      );
                    } else {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("No User Exist")));
                    }

                    //get user fom hive

                    //redirect user to home
                  }
                },
                subject: "Login",
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account"),
                  InkWell(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child: Text("Create Account"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
