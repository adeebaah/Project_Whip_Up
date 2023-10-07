import 'package:flutter/material.dart';
import 'package:whip_up/Screens/Welcome/welcome_screen.dart';
import 'package:whip_up/constants.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAFK2EMtqjKI8nB1ztentSBKj0BoRHIrsk",
      appId: "1:325982503438:android:4ba513fb84b7ad6baf725f",
      messagingSenderId: "325982503438",
      projectId: "whip-up-123",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: welcomeScreen(),
    );
  }
}
