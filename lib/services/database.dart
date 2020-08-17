import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_jaram_together/services/user.dart';

class DataBaseHelper {
  final CollectionReference _usersCollectionReference = Firestore.instance.collection("usersInfo");
  final _firestore = Firestore.instance;
  Future createUserData(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getUserData(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return userData;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
