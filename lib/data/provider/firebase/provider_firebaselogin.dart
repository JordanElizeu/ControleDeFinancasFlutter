import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/data/provider/firebase_exceptions/firebase_exceptions.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProviderLoginFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signInWithFirebase(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Controller().finishAndPageTransition(
                route: Routes.HOME,
                context: context,
              ));
    } on FirebaseAuthException catch (exception) {
      return ProviderFirebaseExceptions().handleFirebaseLoginWithCredentialsException(
          exceptionMessage: exception);
    }
  }

  Future<String?> createFirebaseUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (exception) {
      return ProviderFirebaseExceptions()
          .handleFirebaseCreateUserWithEmailAndPasswordException(
              exceptionMessage: exception);
    }
  }

  Future<String?> forgotPassword(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch(exception){
      return ProviderFirebaseExceptions()
          .handleFirebaseSendPasswordResetEmailException(
          exceptionMessage: exception);
    }
  }
}
