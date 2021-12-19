import 'package:app_financeiro/data/model/model_login/model_login.dart';
import 'package:app_financeiro/data/provider/firebase/provider_firebaselogin.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepositoryFirebaseLogin {
  FirebaseAuth _auth = RepositoryConnection.connectionFirebaseAuth();

  Future<String?> repositorySignInFirebase(
      {required ModelLogin modelLogin}) async {
    return await ProviderLoginFirebase(_auth)
        .providerSignInWithFirebase(modelLogin: modelLogin);
  }
}
