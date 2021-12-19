import 'package:app_financeiro/data/model/model_login/model_createuser.dart';
import 'package:app_financeiro/data/model/model_login/model_login.dart';
import 'package:app_financeiro/data/repository/firebase/repository_createuser.dart';
import 'package:app_financeiro/data/repository/firebase/repository_firebaselogin.dart';
import 'package:app_financeiro/data/repository/firebase/repository_googleconnection.dart';
import 'package:app_financeiro/data/repository/firebase/repository_informationofuser.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'controller.dart';

class LoginController extends GetxController {
  Duration get loginTime => Duration(milliseconds: 2250);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final BuildContext _context;

  LoginController(this._context);

  bool userIsOn() {
    if (_auth.currentUser != null) {
      print(_auth.currentUser!.displayName);
      return true;
    }
    return false;
  }

  void logoutAccount({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    Controller()
        .finishAndPageTransition(route: Routes.LOGIN_INITIAL, context: context);
  }

  Future<String?> signInGoogle({required BuildContext context}) async {
    return await RepositoryGoogleConnection().repositorySignInGoogle(context);
  }

  Future<String?> signInFirebase(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return RepositoryFirebaseLogin().repositorySignInFirebase(
          modelLogin: ModelLogin(data.password, data.name, _context));
    });
  }

  Future<String?> signUpFirebase(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return RepositoryCreateUser().repositorySignUpFirebase(
          modelCreateUser: ModelCreateUser(data.password!, data.name!, _context,
              data.additionalSignupData!['name'].toString()));
    });
  }

  Future<String?> forgotPasswordFirebase(String email) {
    return Future.delayed(loginTime).then((_) {
      return RepositoryInformationOfUser()
          .repositoryForgotPasswordFirebase(email: email);
    });
  }

  String? validation(String? text){
    if(text!.length > 20){
      return 'Nome muito grande';
    }
    if(text.isEmpty){
      return 'Digite seu nome';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
