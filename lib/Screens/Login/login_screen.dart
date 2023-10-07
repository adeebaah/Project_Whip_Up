import 'package:flutter/material.dart';
import 'package:whip_up/Screens/Login/components/body.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // You can handle state specific to the login screen here
  String email = '';
  String password = '';

  void updateEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void updatePassword(String value) {
    setState(() {
      password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        email: email,
        password: password,
        updateEmail: updateEmail,
        updatePassword: updatePassword,
      ),
    );
  }
}
