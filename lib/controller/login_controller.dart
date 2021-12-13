import 'package:app_financeiro/data/repository/firebase/repository_firebaselogin.dart';
import 'package:app_financeiro/data/repository/firebase/repository_googleconnection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Duration get loginTime => Duration(milliseconds: 2250);
  final BuildContext _context;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginController(this._context);

  bool userIsOn() {
    if (_auth.currentUser != null) {
      print(_auth.currentUser!.displayName);
      return true;
    }
    return false;
  }

  Future<String?> signInGoogle() async {
    return await RepositoryGoogleConnection().signInGoogle(_context);
  }

  Future<String?> signInFirebase(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return RepositoryFirebaseLogin()
          .signInFirebase(_context, data.name, data.password);
    });
  }

  Future<String?> signUpFirebase(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return RepositoryFirebaseLogin()
          .signUpFirebase(_context, data.name!, data.password!);
    });
  }

  Future<String?> forgotPasswordFirebase(String email) {
    return Future.delayed(loginTime).then((_) {
      return RepositoryFirebaseLogin().forgotPasswordFirebase(_context, email);
    });
  }
}
