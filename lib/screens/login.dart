import 'package:finance_app/widgets/custom_button.dart';
import 'package:finance_app/widgets/custom_text_form_fields.dart';
import 'package:flutter/material.dart';

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
                
                textEditingController: _emailController,
                hintText: "Enter your Email",
                isPassword: false,
                obscureText: false,
              ),
              SizedBox(height: 20),
              CustomTextFormFields(
                textEditingController: _passwordController,
                hintText: "Enter the password",
                obscureText: true,
                isPassword: true,
              ),
              SizedBox(height: 30),
              CustomButton(
                onPressed: () {
                  //login logic

                  //get user fom hive

                  //redirect user to home
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
