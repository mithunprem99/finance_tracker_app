import 'package:finance_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
  final authService = Provider.of<AuthService>(context);  
    return Scaffold(body: FutureBuilder(future: authService.getCUrrentUser(), builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }else{
        if(snapshot.hasData){
          final user = snapshot.data;
          return Center(child: Text(user!.name),);
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }
    }));
  }
}