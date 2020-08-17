import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jaram_together/components/curved_list_item.dart';
import 'package:flutter_jaram_together/components/custom_text_field.dart';
import 'package:flutter_jaram_together/screens/home_screen.dart';
import 'package:flutter_jaram_together/services/database.dart';
import 'package:flutter_jaram_together/services/sharedpref.dart';
import 'package:flutter_jaram_together/services/user.dart';
import 'package:flutter_jaram_together/style/styles.dart';

import '../components/fade_route.dart';
import '../style/styles.dart';

class NewBieSettingScreen extends StatefulWidget {
  @override
  _NewBieSettingScreenState createState() => _NewBieSettingScreenState();
}

class _NewBieSettingScreenState extends State<NewBieSettingScreen> {
  final nickNameController = TextEditingController();
  Sharedpref sharedpref = Sharedpref();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatePref();
  }

  void updatePref() async {
    await sharedpref.updateStringSetting("user_last_screen", "newbie_setting_screen");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: wmintCream,
        body: Column(
          children: [
            CurvedListItem(
              title: '이름을 알려주세요!',
              color: wskyBlueCrystal,
              nextColor: wmintCream,
              child: Row(
                children: [
                  Text(
                    '닉네임 : ',
                    style: wscreenTitle,
                  ),
                  Flexible(
                    child: CustomTextField(
                      controller: nickNameController,
                      textInputType: TextInputType.text,
                      hintText: '여기에 이름을 알려주세요!',
                      inputStyle: wscreenTitle,
                      cursorColor: Colors.grey[600],
                      onChanged: (value) {
                        setState(() {});
                      },
                      maxLength: 5,
                      counterText: "",
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp(r"\s+"), allow: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              children: [
                Spacer(),
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () async {
                      DataBaseHelper dataBaseHelper = DataBaseHelper();

                      final nickName = await sharedpref.getStringSetting("user_nickName");
                      setState(() {});
                      if (nickName == null || nickName == "") {
                        await sharedpref.updateStringSetting("user_nickName", nickNameController.text);
                        final userUid = await sharedpref.getStringSetting("user_uid");
                        final userEmail = await sharedpref.getStringSetting("user_email");
                        setState(() {});
                        if (userUid == null || userUid == "") {
                          print("error");
                        } else {
                          await dataBaseHelper.createUserData(User(
                            id: userUid,
                            nickName: nickNameController.text,
                            email: userEmail,
                            podRole: [],
                            groupRole: [],
                          ));
                          Navigator.pushReplacement(context, FadeRoute(page: HomeScreen()));
                        }
                      }
                      // remove empty string and saving
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        nickNameController.text.length != 0 ? '설정완료!' : '이름을 설정해주세요!',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: wskyBlueCrystal,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [wBoxshadow],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
