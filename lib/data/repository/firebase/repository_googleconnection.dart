import 'package:app_financeiro/data/provider/firebase/provider_createuser.dart';
import 'package:app_financeiro/data/provider/firebase/provider_googlelogin.dart';
import 'package:app_financeiro/data/provider/firebase/provider_informationsofuser.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

final FirebaseAuth _auth = RepositoryConnection.connectionFirebaseAuth();
final DatabaseReference _databaseReference =
    RepositoryConnection.connectionDatabase();

class RepositoryGoogleConnection {
  ProviderCreateUser _providerCreateUser =
      ProviderCreateUser(_auth, _databaseReference);
  ProviderInformationOfUser _providerInformationOfUser =
      ProviderInformationOfUser(_auth);

  Future<String?> repositorySignInGoogle(BuildContext context) async {
    return await ProviderGoogleLogin().signInWithGoogle(
        context: context,
        providerCreateUser: _providerCreateUser,
        providerInformationOfUser: _providerInformationOfUser);
  }
}
