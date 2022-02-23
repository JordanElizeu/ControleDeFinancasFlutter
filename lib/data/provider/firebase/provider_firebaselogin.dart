import 'package:app_financeiro/data/model/model_login/model_login.dart';
import 'package:app_financeiro/data/provider/firebase_exceptions/firebase_exceptions.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../utils/transition_page.dart';

class ProviderLoginFirebase {
  final RepositoryConnection repositoryConnection;

  ProviderLoginFirebase({required this.repositoryConnection});

  Future<String?> providerSignInWithFirebase(
      {required ModelLogin modelLogin}) async {
    try {
      await repositoryConnection
          .connectionFirebaseAuth()
          .signInWithEmailAndPassword(
              email: modelLogin.email, password: modelLogin.password)
          .then((value) => TransitionPage().finishAndPageTransition(
              route: Routes.HOME, context: modelLogin.context));
    } on FirebaseAuthException catch (exception) {
      return ProviderFirebaseExceptions()
          .handleFirebaseLoginWithCredentialsException(
              exceptionMessage: exception);
    }
    return null;
  }

  Future<String?> providerForgotPassword(String email) async {
    try {
      await repositoryConnection
          .connectionFirebaseAuth()
          .sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (exception) {
      return ProviderFirebaseExceptions()
          .handleFirebaseSendPasswordResetEmailException(
              exceptionMessage: exception);
    }
    return null;
  }
}
