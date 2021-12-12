import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProviderLoginFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signInWithFirebase(
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
    } on FirebaseAuthException catch (exception) {}
  }

  void createFirebaseUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try{
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => Controller().finishAndPageTransition(
        route: Routes.LOGIN,
        context: context,
      ));
    }on FirebaseAuthException catch(exception){

    }
  }
}
