import 'package:app_financeiro/data/provider/firebase/provider_firebaselogin.dart';
import 'package:flutter/cupertino.dart';

class RepositoryFirebaseLogin{

  void signUpFirebase(BuildContext context, String email, String password){
    ProviderLoginFirebase().createFirebaseUser(email, password, context);
  }

  Future<String?> signInFirebase(BuildContext context, String email, String password) async{
    return await ProviderLoginFirebase().signInWithFirebase(email, password, context);
  }

  void forgotPasswordFirebase(BuildContext context, String email){
    ProviderLoginFirebase().forgotPassword(email);
  }
}