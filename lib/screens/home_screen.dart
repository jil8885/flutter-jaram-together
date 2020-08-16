import 'package:flutter/material.dart';
import 'package:flutter_jaram_together/style/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wdarkBlueColor,
      body: SafeArea(
        child: Center(
          child: Text('HOME'),
        ),
      ),
    );
  }
}
