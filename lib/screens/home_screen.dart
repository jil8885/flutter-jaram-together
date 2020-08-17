import 'package:flutter/material.dart';
import 'package:flutter_jaram_together/components/fade_route.dart';
import 'package:flutter_jaram_together/screens/login_screen.dart';
import 'package:flutter_jaram_together/services/auth.dart';
import 'package:flutter_jaram_together/services/sharedpref.dart';
import 'package:flutter_jaram_together/style/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Sharedpref sharedpref = Sharedpref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatePref();
  }

  void updatePref() async {
    await sharedpref.updateStringSetting("user_last_screen", "home_screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wmintCream,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('HOME'),
              FlatButton(
                onPressed: () async {
                  AuthHelper authHelper = AuthHelper();
                  await authHelper.outCurrentuser();
                  popupData();
                  Navigator.pushReplacement(context, FadeRoute(page: LoginScreen()));
                },
                child: Text('로그아웃'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void popupData() async {
    await sharedpref.updateStringSetting("user_last_screen", "login_screen");
    await sharedpref.updateStringSetting("user_uid", "");
    await sharedpref.updateStringSetting("user_email", "");
    await sharedpref.updateStringSetting("user_nickName", "");
    await sharedpref.updateStringListSetting("user_podRole", []);
    await sharedpref.updateStringListSetting("user_groupRole", []);
  }
}
