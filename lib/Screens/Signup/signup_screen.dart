import 'package:flutter/material.dart';
import 'package:whip_up/Screens/Signup/components/body.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
