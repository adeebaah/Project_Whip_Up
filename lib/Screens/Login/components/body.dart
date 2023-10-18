import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whip_up/Screens/Login/components/background.dart';
import 'package:whip_up/Screens/Signup/signup_screen.dart';
import 'package:whip_up/components/already_have_an_account_check.dart';
import 'package:whip_up/components/rounded_button.dart';
import 'package:whip_up/components/rounded_input_field.dart';
import 'package:whip_up/components/rounded_password_field.dart';
// import 'package:whip_up/components/text_field_container.dart';
// import 'package:whip_up/constants.dart';
import 'package:whip_up/Screens/Signup/api_service.dart';
import 'package:whip_up/Screens/Welcome/welcome_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
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
          // RoundedInputField(
          //   hintText: "Your Email",
          //   onChanged: (value) {},
          // ),
          RoundedInputField(
            hintText: "Your Email",
            icon: Icons.email, // This is the missing argument you need to add.
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
          RoundedPasswordField(
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
          ),
          // RoundedPasswordField(
          //   onChanged: (value) {},
          // ),

          // RoundedButton(
          //   text: "LogIn",
          //   press: () {},
          // ),
          //  RoundedButton(
          //     text: "LOGIN",
          //     press: () async {
          //       final apiService = ApiService();
          //       try {
          //         var result = await apiService.loginUser(_email, _password);
          //         print(result);
          //         // Handle the response from your backend as needed.
          //       } catch (error) {
          //         print(error);
          //         // Show an error message to the user, maybe using a Snackbar.
          //       }
          //     },
          //   ),

          RoundedButton(
            text: "LOGIN",
            press: () async {
              final apiService = ApiService();
              try {
                var result = await apiService.loginUser(_email, _password);
                print(result);
                // Assuming 'result' contains a message or status indicating a successful login
                // You should replace 'successMessage' with the actual success response you expect from your API
                if (result['message'] == 'Login Successful') {
                  // Navigate to WelcomeScreen after successful login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => welcomeScreen(),
                    ),
                  );
                } else {
                  // Handle other responses from your backend as needed, e.g., showing an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login Failed! Please try again.')),
                  );
                }
              } catch (error) {
                print(error);
                // Show an error message to the user, using a Snackbar.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('An error occurred. Please try again.')),
                );
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
    );
  }
}
