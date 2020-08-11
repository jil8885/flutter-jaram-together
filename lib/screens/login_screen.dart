import 'package:flutter/material.dart';
import 'package:flutter_jaram_together/screens/Intro_screen.dart';
import 'package:flutter_login/flutter_login.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
  'a@gmail.com': '12345',
};

final email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '너팟내팟',
      // logo: 'assets/images/jaram-logo.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => IntroScreen(),
        ));
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
  if (value.isEmpty || value.length <= 2) {
    return '비밀번호가 너무 짧아요.';
  }
  return null;
};
