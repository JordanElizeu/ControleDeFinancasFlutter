import 'package:app_financeiro/data/model/login_model/create_user_model.dart';
import 'package:app_financeiro/data/model/login_model/model_login.dart';
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
import '../utils/transition_page.dart';
import 'home_controller.dart';

class LoginController extends GetxController {
  Duration get loginTime => Duration(seconds: 2);

  final RepositoryInformationOfUser _repositoryInformationOfUser =
      getIt.get<RepositoryInformationOfUser>();
  final TransitionPage _transitionController = getIt.get<TransitionPage>();
  final RepositoryGoogleConnection _repositoryGoogleConnection =
      getIt.get<RepositoryGoogleConnection>();
  final RepositoryCreateUser _repositoryCreateUser =
      getIt.get<RepositoryCreateUser>();
  final RepositoryFirebaseLogin _repositoryFirebaseLogin =
      getIt.get<RepositoryFirebaseLogin>();
  bool pageIsLoading = false;

  void pageLoadingState() async {
    await Future.delayed(Duration(seconds: 3));
    pageIsLoading = true;
    update();
  }

  Future<bool> logoutAccount({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await _transitionController.finishAndPageTransition(
        route: Routes.INITIAL, context: context);
    HomeController.moneyValue = null;
    return true;
  }

  Future<String?> signInGoogle({required BuildContext context}) async {
    return await _repositoryGoogleConnection.repositorySignInGoogle(context);
  }

  Future<String?> signInFirebase(LoginData data) async {
    return await _repositoryFirebaseLogin.repositorySignInFirebase(
        loginModel: LoginModel(
            email: data.name, password: data.password, context: Get.context));
  }

  Future<String?> signUpFirebase(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return _repositoryCreateUser.repositorySignUpFirebase(
          modelCreateUser: CreateUserModel(data.password!, data.name!,
              Get.context!, data.additionalSignupData![columnName].toString()));
    });
  }

  Future<String?> forgotPasswordFirebase(String email) {
    return Future.delayed(loginTime).then((_) {
      return _repositoryInformationOfUser.repositoryForgotPasswordFirebase(
          email: email);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
