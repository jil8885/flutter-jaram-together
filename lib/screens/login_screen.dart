import 'package:flutter/material.dart';
import 'package:flutter_jaram_together/components/fade_route.dart';
import 'package:flutter_jaram_together/screens/Intro_screen.dart';
import 'package:flutter_jaram_together/screens/home_screen.dart';
import 'package:flutter_jaram_together/services/auth.dart';
import 'package:flutter_jaram_together/services/database.dart';
import 'package:flutter_jaram_together/services/sharedpref.dart';
import 'package:flutter_login/flutter_login.dart';

// const users = const {
//   'dribbble@gmail.com': '12345',
//   'hunter@gmail.com': 'hunter',
//   'a@gmail.com': '12345',
// };

final email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Sharedpref sharedpref = Sharedpref();
  bool isLogin = false;
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _loginUser(LoginData data) {
    AuthHelper authHelper = AuthHelper(email: data.name);
    return Future.delayed(loginTime).then((_) async {
      final result = await authHelper.login(data.password);
      if (result == 'ERROR_INVALID_EMAIL') {
        return '이메일이 올바르지 않아요';
      } else if (result == 'ERROR_USER_NOT_FOUND') {
        return '이메일 혹은 비밀번호가 일치하지 않아요';
      } else if (result == 'ERROR_WRONG_PASSWORD') {
        return '이메일 혹은 비밀번호가 일치하지 않아요';
      } else if (result == 'ERROR') {
        return '알 수 없는 오류가 발생했어요.';
      }

      sharedpref.updateStringSetting("user_email", data.name);
      // sharedpref.updateStringListSetting("user_groupRole", ["1", "admin"]); test value
      return null;
    });
  }

  Future<String> _registerUser(LoginData data) {
    AuthHelper authHelper = AuthHelper(email: data.name);
    return Future.delayed(loginTime).then((_) async {
      final result = await authHelper.registration(data.password);

      if (result == 'ERROR_INVALID_EMAIL') {
        return '이메일이 올바르지 않아요';
      } else if (result == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return '이 이메일은 이미 사용 중 이예요';
      } else if (result == 'ERROR_WEAK_PASSWORD') {
        return '비밀번호가 너무 짧아요 (6자리 이상)';
      } else if (result == 'ERROR') {
        return '알 수 없는 오류가 발생했어요.';
      }
      sharedpref.updateStringSetting("user_email", data.name);
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    AuthHelper authHelper = AuthHelper(email: name);
    return Future.delayed(loginTime).then((_) async {
      final result = await authHelper.resetPassword();
      if (result == 'ERROR_INVALID_EMAIL') {
        return '이메일이 올바르지 않아요';
      } else if (result == 'ERROR_USER_NOT_FOUND') {
        return '이 이메일으로는 가입이 되지 않았어요';
      } else if (result == 'ERROR') {
        return '알 수 없는 오류가 발생했어요.';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '너팟내팟',
      // logo: 'assets/images/jaram-logo.png',
      onLogin: _loginUser,
      onSignup: _registerUser,

      onSubmitAnimationCompleted: () async {
        final _userUid = await sharedpref.getStringSetting("user_uid");
        if (_userUid == "") {
          AuthHelper authHelper = AuthHelper();
          final _user = await authHelper.getCurrentuser();
          DataBaseHelper dataBaseHelper = DataBaseHelper();
          await sharedpref.updateStringSetting("user_uid", _user.uid);
          final _userData = await dataBaseHelper.getUserData(_user.uid);
          if (_userData.data == null) {
            Navigator.pushReplacement(context, FadeRoute(page: IntroScreen()));
          } else {
            await sharedpref.updateStringSetting("user_nickName", _userData.data["nickName"]);
            await sharedpref.updateStringSetting("user_groupRole", _userData.data["groupRole"]);
            await sharedpref.updateStringSetting("user_podRole", _userData.data["podRole"]);
            Navigator.pushReplacement(context, FadeRoute(page: HomeScreen()));
          }
        }
      },

      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
        beforeHeroFontSize: 24.0,
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      emailValidator: customEmailValidator,
      passwordValidator: customPasswordValidator,
      messages: LoginMessages(
        usernameHint: '이메일',
        passwordHint: '비밀번호',
        signupButton: '회원가입',
        confirmPasswordHint: '비밀번호 확인',
        confirmPasswordError: '비밀번호가 일치하지 않아요.',
        loginButton: '로그인',
        forgotPasswordButton: '비밀번호 찾기',
        recoverPasswordIntro: '비밀번호 찾기',
        recoverPasswordDescription: '가입된 이메일 계정을 입력해줘요.\n저희가 찾아드릴께요!',
        recoverPasswordButton: '임시 비밀번호 발급',
        recoverPasswordSuccess: '이메일을 확인해보세요!',
        goBackButton: '뒤로가기',
      ),
    );
  }
}

final FormFieldValidator<String> customEmailValidator = (value) {
  if (value.isEmpty || !email.hasMatch(value)) {
    return '이메일이 올바르지 않아요.';
  }
  return null;
};

final FormFieldValidator<String> customPasswordValidator = (value) {
  if (value.isEmpty || value.length <= 5) {
    return '비밀번호가 너무 짧아요 (6자리 이상)';
  }
  return null;
};
