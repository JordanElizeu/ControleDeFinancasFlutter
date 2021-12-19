import 'package:app_financeiro/data/model/model_login/model_createuser.dart';
import 'package:app_financeiro/data/provider/firebase/provider_createuser.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RepositoryCreateUser{

  FirebaseAuth _auth = RepositoryConnection.connectionFirebaseAuth();
  DatabaseReference _databaseReference =
  RepositoryConnection.connectionDatabase();

  Future<String?> repositorySignUpFirebase(
      {required ModelCreateUser modelCreateUser}) async {
    return await ProviderCreateUser(_auth, _databaseReference)
        .providerCreateFirebaseUser(modelCreateUser: modelCreateUser);
  }
}