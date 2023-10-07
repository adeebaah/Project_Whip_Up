import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whip_up/Screens/Login/components/background.dart';
import 'package:whip_up/Screens/Signup/signup_screen.dart';
import 'package:whip_up/components/already_have_an_account_check.dart';
import 'package:whip_up/components/rounded_button.dart';
import 'package:whip_up/components/rounded_input_field.dart';
import 'package:whip_up/components/rounded_password_field.dart';
import 'package:firebase_core/firebase_core.dart';

class Body extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final String email;
  final String password;
  final ValueChanged<String> updateEmail;
  final ValueChanged<String> updatePassword;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Body({
    Key? key,
    required this.email,
    required this.password,
    required this.updateEmail,
    required this.updatePassword,
  }) : super(key: key); // Create a GlobalKey<FormState>

  Future<void> loginUser(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print('Login successful for ${userCredential.user?.email}');
        // Navigate to your home screen or wherever you want after successful login
      } on FirebaseAuthException catch (e) {
        print('Failed to sign in: $e');
        // Handle login errors, e.g., show a snackbar or an error message
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        // Wrap your content with a Form widget
        key: _formKey, // Assign the GlobalKey
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LogIn",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedInputField(
              hintText: "Your Email",
              icon: Icons.person,
              onChanged: (value) {
                _emailController.text = value;
              },
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
              onChanged: (value) {
                _passwordController.text = value;
              },
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
              text: "Login",
              press: () {
                if (_formKey.currentState!.validate()) {
                  loginUser(context);
                }
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupScreen();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
