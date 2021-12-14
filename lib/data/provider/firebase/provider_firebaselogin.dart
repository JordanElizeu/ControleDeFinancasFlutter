import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/data/provider/firebase_exceptions/firebase_exceptions.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ProviderLoginFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<String?> providerSignInWithFirebase(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Controller(context).finishAndPageTransition(
                route: Routes.HOME,
              ));
    } on FirebaseAuthException catch (exception) {
      return ProviderFirebaseExceptions().handleFirebaseLoginWithCredentialsException(
          exceptionMessage: exception);
    }
  }

  Future<String> providerGetNameIfUserIsFromFirebase() async {
    DatabaseReference _databaseReference = FirebaseDatabase.instance
        .ref('AppFinancas/${_auth.currentUser!.uid}/Account');
    DatabaseEvent event = await _databaseReference.once();
    return event.snapshot.child('name').value.toString();
  }

  Future<String?> providerCreateFirebaseUser(
    String email,
    String password,
    String name,
    BuildContext context,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _databaseReference
          .child('AppFinancas')
          .child(_auth.currentUser!.uid)
          .child('Account')
          .child('name')
          .set(name);
      _databaseReference
          .child('AppFinancas')
          .child(_auth.currentUser!.uid)
          .child('Account')
          .child('Finances')
          .child('money')
          .set('0');
    } on FirebaseAuthException catch (exception) {
      return ProviderFirebaseExceptions()
          .handleFirebaseCreateUserWithEmailAndPasswordException(
              exceptionMessage: exception);
    }
  }

  Future<String?> providerForgotPassword(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(exception){
      return ProviderFirebaseExceptions()
          .handleFirebaseSendPasswordResetEmailException(
          exceptionMessage: exception);
    }
  }
}
