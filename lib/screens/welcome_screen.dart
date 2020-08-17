import 'package:flutter/material.dart';
import 'package:flutter_jaram_together/components/fade_route.dart';
import 'package:flutter_jaram_together/screens/home_screen.dart';
import 'package:flutter_jaram_together/screens/login_screen.dart';
import 'package:flutter_jaram_together/screens/newbie_setting_screen.dart';
import 'package:flutter_jaram_together/services/sharedpref.dart';
import 'package:flutter_jaram_together/style/styles.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Sharedpref sharedpref = Sharedpref();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preparingData();
    checkingInitData();
  }

  void checkingInitData() async {
    final userLastScreen = await sharedpref.getStringSetting("user_last_screen");
    setState(() {});
    print(userLastScreen);
    if (userLastScreen == null || userLastScreen == "") {
      await sharedpref.prepareStringSetting("user_last_screen", "login_screen");
      Navigator.pushReplacement(context, FadeRoute(page: LoginScreen()));
    } else {
      if (userLastScreen == "login_screen") {
        Navigator.pushReplacement(context, FadeRoute(page: LoginScreen()));
      }
      if (userLastScreen == "home_screen") {
        Navigator.pushReplacement(context, FadeRoute(page: HomeScreen()));
      }
      if (userLastScreen == "newbie_setting_screen") {
        Navigator.pushReplacement(context, FadeRoute(page: NewBieSettingScreen()));
      }
    }
  }

  void preparingData() async {
    await sharedpref.prepareStringSetting("user_last_screen", "login_screen");
    await sharedpref.prepareStringSetting("user_uid", "");
    await sharedpref.prepareStringSetting("user_email", "");
    await sharedpref.prepareStringSetting("user_nickName", "");
    await sharedpref.prepareStringListSetting("user_podRole", []);
    await sharedpref.prepareStringListSetting("user_groupRole", []);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wskyBlueCrystal,
      body: Center(
        child: Text(
          '너팟내팟',
          style: wscreenTitle.copyWith(fontSize: 32),
        ),
      ),
    );
  }
}
