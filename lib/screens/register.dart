import 'package:finance_app/models/user_models.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:finance_app/widgets/custom_button.dart';
import 'package:finance_app/widgets/custom_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: double.infinity,
              width: double.infinity,
              child: Form(
                key: _registerKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 170,
                      height: 170,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormFields(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter the username";
                        }
                      },
                      textEditingController: _nameController,
                      hintText: "Enter the username",
                      obscureText: false,
                      isPassword: false,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormFields(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter the email";
                        }
                        if (!value.contains('@')) {
                          return 'Enter the correct email format';
                        }
                      },
                      textEditingController: _emailController,
                      hintText: "Enter the email",
                      obscureText: false,
                      isPassword: false,
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
                    SizedBox(height: 20),
                    CustomTextFormFields(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please re-enter the password';
                        }
                        if (value.length <= 6) {
                          return 'Enter the password with minimum length of 6';
                        }
                        if(_passwordController.text != _confirmPasswordController.text){
                          return "Password mis-match";
                        }
                      },
                      textEditingController: _confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: true,
                      isPassword: true,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormFields(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the phone number';
                        }
                      },
                      keyboardType: TextInputType.numberWithOptions(),

                      textEditingController: _numberController,
                      hintText: "Enter the phone number",
                      obscureText: false,
                      isPassword: false,
                      
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      onPressed: () async{
                        var uuid = Uuid().v1();
                        if (_registerKey.currentState!.validate()) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Center(child: CircularProgressIndicator());
                            },
                          );
                          UserModels user = UserModels(  
                            id: uuid,
                            email: _emailController.text.trim(),
                            name: _nameController.text.trim(),
                            password: _passwordController.text.trim(),
                            phonenumber: _numberController.text.trim(),
                            status: 1,
                          );

                          final res = await authService.registerUser(user);
                            Navigator.pop(context);
                          
                          if(res == true){

                            Navigator.pop(context);
                          }
                        }
  
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
          ),
        ],
      ),
    );
  }
}
