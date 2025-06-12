import 'package:flutter/material.dart';
import 'package:villa_vie/Auth/OTP_verification_page.dart';
import 'package:villa_vie/Auth/sign_up_page.dart';
import 'package:villa_vie/Pages/Profile.dart';
import 'package:villa_vie/Pages/home_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}