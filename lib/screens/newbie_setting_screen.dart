import 'package:flutter/material.dart';
import 'package:flutter_jaram_together/components/curved_list_item.dart';
import 'package:flutter_jaram_together/components/custom_text_field.dart';
import 'package:flutter_jaram_together/style/styles.dart';
import 'package:flutter_jaram_together/components/fade_route.dart';

class NewBieSettingScreen extends StatefulWidget {
  @override
  _NewBieSettingScreenState createState() => _NewBieSettingScreenState();
}

class _NewBieSettingScreenState extends State<NewBieSettingScreen> {
  final nickNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: wmintCream,
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                    onTap: () {
                      Navigator.pushReplacement(context, FadeRoute(page: NewBieSettingScreen()));
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
