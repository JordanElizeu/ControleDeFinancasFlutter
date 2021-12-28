import 'package:app_financeiro/controller/transition_controller.dart';
import 'package:app_financeiro/data/model/model_login/model_login.dart';
import 'package:app_financeiro/data/provider/firebase_exceptions/firebase_exceptions.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProviderLoginFirebase {
  final FirebaseAuth _auth;

  ProviderLoginFirebase(this._auth);

  Future<String?> providerSignInWithFirebase(
      {required ModelLogin modelLogin}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: modelLogin.email,
              password: modelLogin.password)
          .then((value) => TransitionController().finishAndPageTransition(
              route: Routes.HOME, context: modelLogin.context));
    } on FirebaseAuthException catch (exception) {
      return ProviderFirebaseExceptions()
          .handleFirebaseLoginWithCredentialsException(
              exceptionMessage: exception);
    }
  }

  Future<String?> providerForgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (exception) {
      return ProviderFirebaseExceptions()
          .handleFirebaseSendPasswordResetEmailException(
          exceptionMessage: exception);
    }
  }
}
