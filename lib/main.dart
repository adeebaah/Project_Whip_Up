import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whip_up/Screens/Welcome/welcome_screen.dart';
import 'package:whip_up/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCBopbljvmRvSIaaOTgvzRlUezW5YzmdM8",
          appId: "1:476163344647:android:172c2c4f569326184fdda2",
          messagingSenderId: "476163344647",
          projectId: "fir-app-6233b"));
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
