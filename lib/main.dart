import 'package:flutter/material.dart';
import 'package:flutter_jaram_together/screens/Intro_screen.dart';
import 'package:flutter_jaram_together/screens/login_screen.dart';
import 'package:flutter_jaram_together/style/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '너팟내팟',
      theme: ThemeData(
        primarySwatch: mdarkBlue,
        cardColor: kbannaColor,
        accentColor: kdarkBlueColor,
        cursorColor: Colors.brown,
        textTheme: TextTheme(
          display2: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
