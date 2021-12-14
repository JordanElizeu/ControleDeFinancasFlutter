import 'package:app_financeiro/data/provider/firebase/provider_firebaselogin.dart';
import 'package:flutter/cupertino.dart';

class RepositoryFirebaseLogin {
  Future<String?> signUpFirebase(
      BuildContext context, String email, String password, String name) async {
    return await ProviderLoginFirebase()
        .createFirebaseUser(email, password, name, context);
  }

  Future<String> getNameIfUserIsFromFirebase() async {
    return await ProviderLoginFirebase().getNameIfUserIsFromFirebase();
  }

  Future<String?> signInFirebase(
      BuildContext context, String email, String password) async {
    return await ProviderLoginFirebase()
        .signInWithFirebase(email, password, context);
  }

  Future<String?> forgotPasswordFirebase(
      BuildContext context, String email) async {
    return await ProviderLoginFirebase().forgotPassword(email);
  }
}
