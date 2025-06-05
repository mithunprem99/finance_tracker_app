import 'package:finance_app/widgets/custom_button.dart';
import 'package:finance_app/widgets/custom_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
 final _registerKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _registerKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 170, height: 170),
              SizedBox(height: 20),
              CustomTextFormFields(
                textEditingController: _nameController,
                hintText: "Enter the username",
                obscureText: false,
                isPassword: false,
              ),
              SizedBox(height: 20),
              CustomTextFormFields(
                textEditingController: _emailController,
                hintText: "Enter the email",
                obscureText: false,
                isPassword: false,
              ),
              SizedBox(height: 20),
              CustomTextFormFields(
                textEditingController: _passwordController,
                hintText: "Enter the password",
                obscureText: true,
                isPassword: true,
              ),
              SizedBox(height: 20),
              CustomTextFormFields(
                textEditingController: _confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true,
                isPassword: true,
              ),
              SizedBox(height: 20),
              CustomTextFormFields(
                keyboardType: TextInputType.numberWithOptions(),
                
                textEditingController: _numberController,
                hintText: "Enter the phone number",
                obscureText: false,
                isPassword: false,
              ),
              SizedBox(height: 30),
             CustomButton(
                  onPressed: () {
                    //login logic
          
                    //get user fom hive
          
                    //redirect user to home
                  },
                  subject: "Register",
                ),
                SizedBox(height: 20),
                              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account"),
                    InkWell(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Text("Login"),
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
