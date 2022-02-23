import 'package:app_financeiro/data/model/model_login/model_createuser.dart';
import 'package:app_financeiro/data/model/model_login/model_login.dart';
import 'package:app_financeiro/data/repository/firebase/repository_createuser.dart';
import 'package:app_financeiro/data/repository/firebase/repository_firebaselogin.dart';
import 'package:app_financeiro/data/repository/firebase/repository_googleconnection.dart';
import 'package:app_financeiro/data/repository/firebase/repository_informationofuser.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/string_i18n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'transition_controller.dart';

class LoginController extends GetxController {
  Duration get loginTime => Duration(milliseconds: 2250);

  final RepositoryInformationOfUser _repositoryInformationOfUser =
      getIt.get<RepositoryInformationOfUser>();
  final TransitionController _transitionController =
      getIt.get<TransitionController>();
  final RepositoryGoogleConnection _repositoryGoogleConnection =
      getIt.get<RepositoryGoogleConnection>();
  final RepositoryCreateUser _repositoryCreateUser =
      getIt.get<RepositoryCreateUser>();
  final RepositoryFirebaseLogin _repositoryFirebaseLogin =
      getIt.get<RepositoryFirebaseLogin>();

  bool userIsOn({required FirebaseAuth auth}) {
    if (auth.currentUser != null) {
      print(auth.currentUser!.displayName);
      return true;
    }
    return false;
  }

  Future<bool> logoutAccount({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    _transitionController.finishAndPageTransition(
        route: Routes.LOGIN_INITIAL, context: context);
    return true;
  }

  Future<String?> signInGoogle({required BuildContext context}) async {
    return await _repositoryGoogleConnection.repositorySignInGoogle(context);
  }

  Future<String?> signInFirebase(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      return await _repositoryFirebaseLogin.repositorySignInFirebase(
          modelLogin: ModelLogin(
              email: data.name, password: data.password, context: Get.context));
    });
  }

  Future<String?> signUpFirebase(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return _repositoryCreateUser.repositorySignUpFirebase(
          modelCreateUser: ModelCreateUser(data.password!, data.name!,
              Get.context!, data.additionalSignupData![columnName].toString()));
    });
  }

  Future<String?> forgotPasswordFirebase(String email) {
    return Future.delayed(loginTime).then((_) {
      return _repositoryInformationOfUser.repositoryForgotPasswordFirebase(
          email: email);
    });
  }

  String? validation(String? text) {
    if (text!.length > 20) {
      return 'Nome muito grande';
    }
    if (text.isEmpty) {
      return 'Digite seu nome';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
