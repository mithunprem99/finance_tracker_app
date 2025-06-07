import 'package:finance_app/models/user_models.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:finance_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final userServide = Provider.of<AuthService>(context);
    print(userServide);
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: FutureBuilder<UserModels?>(
        future: userServide.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator.adaptive();
          } else if (snapshot.hasData) {
            final userData = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12), // optional
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Text(
                        "${userData!.name[0].toUpperCase()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Text(
                      "${userData!.name}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                    Text(
                      "${userData!.email}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Text(
                      "${userData!.phonenumber}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    CustomButton(
                      onPressed: () async {
                        await Provider.of<AuthService>(
                          context,
                          listen: false,
                        ).logOut(context);
                        Navigator.pushReplacementNamed(context, 'login');
                      },
                      subject: "Logout",
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text("User not found");
          }
        },
      ),
    );
  }
}
