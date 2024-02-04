// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/screens/sign_in_screen.dart';
import 'package:ecommerce/screens/sign_up_%20screeen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LogInScreen(),
      // home: SignUpScreen(),
    );
  }
}
