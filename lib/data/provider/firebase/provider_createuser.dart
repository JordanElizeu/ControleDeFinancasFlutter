import 'package:app_financeiro/data/model/model_login/model_createuser.dart';
import 'package:app_financeiro/data/provider/firebase_exceptions/firebase_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProviderCreateUser {
  final FirebaseAuth _auth;
  final DatabaseReference _databaseReference;

  ProviderCreateUser(this._auth, this._databaseReference);

  Future<String?> providerCreateFirebaseUser(
      {required ModelCreateUser modelCreateUser}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: modelCreateUser.email, password: modelCreateUser.password);
      _databaseReference
          .child('AppFinancas')
          .child(_auth.currentUser!.uid)
          .child('Account')
          .child('name')
          .set(modelCreateUser.name);
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

  Future<String?> providerCreateUserGoogle() async {
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('name')
        .set(_auth.currentUser!.displayName);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Finances')
        .child('money')
        .set('0');
  }
}
