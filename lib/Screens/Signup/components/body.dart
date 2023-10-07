import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whip_up/Screens/Login/login_screen.dart';
import 'package:whip_up/Screens/Signup/components/background.dart';
import 'package:whip_up/Screens/Signup/components/or_divider.dart';
import 'package:whip_up/Screens/Signup/components/social_icon.dart';
import 'package:whip_up/components/already_have_an_account_check.dart';
import 'package:whip_up/components/rounded_button.dart';
import 'package:whip_up/components/rounded_input_field.dart';
import 'package:whip_up/components/rounded_password_field.dart';
import 'package:whip_up/constants.dart';

class Body extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final String email;
  final String password;
  final ValueChanged<String> updateEmail;
  final ValueChanged<String> updatePassword;

  Body({
    Key? key,
    required this.email,
    required this.password,
    required this.updateEmail,
    required this.updatePassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        // Wrap your content with a Form widget
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              icon: Icons.person,
              onChanged: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                    .hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null; // Return null if validation passes
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null; // Return null if validation passes
              },
            ),
            RoundedButton(
              text: "Signup",
              press: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, perform the login action
                  // For now, we'll just print a message
                  print('Form is valid, perform signup action');
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            orDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
