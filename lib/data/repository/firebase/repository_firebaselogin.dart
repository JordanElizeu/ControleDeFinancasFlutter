import 'package:app_financeiro/data/provider/firebase/provider_firebaselogin.dart';
import 'package:flutter/cupertino.dart';

class RepositoryFirebaseLogin {
  Future<String?> repositorySignUpFirebase(
      BuildContext context, String email, String password, String name) async {
    return await ProviderLoginFirebase()
        .providerCreateFirebaseUser(email, password, name, context);
  }

  Future<String> repositoryGetNameIfUserIsFromFirebase() async {
    return await ProviderLoginFirebase().providerGetNameIfUserIsFromFirebase();
  }

  Future<String?> repositorySignInFirebase(
      BuildContext context, String email, String password) async {
    return await ProviderLoginFirebase()
        .providerSignInWithFirebase(email, password, context);
  }

  Future<String?> repositoryForgotPasswordFirebase(
      BuildContext context, String email) async {
    return await ProviderLoginFirebase().providerForgotPassword(email);
  }
}
