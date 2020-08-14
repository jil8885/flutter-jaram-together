import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthHelper {
  AuthHelper({
    this.email,
  });
  String email;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _loggedInUser;
  String _authError;
  Future registration(String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(newUser);
      return newUser;
    } catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          _authError = 'ERROR_INVALID_EMAIL';
          break;
        case 'ERROR_WEAK_PASSWORD':
          _authError = 'ERROR_WEAK_PASSWORD';
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          _authError = 'ERROR_EMAIL_ALREADY_IN_USE';
          break;
        default:
          _authError = 'ERROR';
          break;
      }
      return _authError;
    }
  }

  Future login(String password) async {
    try {
      AuthResult user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(user);
      if (user != null) return user;
    } catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          _authError = 'ERROR_INVALID_EMAIL';
          break;
        case 'ERROR_USER_NOT_FOUND':
          _authError = 'ERROR_USER_NOT_FOUND';
          break;
        case 'ERROR_WRONG_PASSWORD':
          _authError = 'ERROR_WRONG_PASSWORD';
          break;
        default:
          _authError = 'ERROR';
          break;
      }
      return _authError;
    }
  }

  Future resetPassword() async {
    try {
      final currentUser = await _auth.sendPasswordResetEmail(email: email);
      return currentUser;
    } catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          _authError = 'ERROR_INVALID_EMAIL';
          break;
        case 'ERROR_USER_NOT_FOUND':
          _authError = 'ERROR_USER_NOT_FOUND';
          break;
        default:
          _authError = 'ERROR';
          break;
      }

      return _authError;
    }
  }

  Future getCurrentuser() async {
    try {
      final user = await _auth.currentUser();
      _loggedInUser = user;
      return _loggedInUser;
    } catch (e) {
      print(e);
    }
  }
}
