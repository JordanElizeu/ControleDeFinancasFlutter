import 'package:app_financeiro/data/provider/firebase/provider_informationsofuser.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepositoryInformationOfUser {
  FirebaseAuth _auth = RepositoryConnection.connectionFirebaseAuth();

  Future<String> repositoryGetNameIfUserIsFromFirebase() async {
    return await ProviderInformationOfUser(_auth)
        .providerGetNameIfUserIsFromFirebase();
  }

  Future<String?> repositoryForgotPasswordFirebase(
      {required String email}) async {
    return await ProviderInformationOfUser(_auth).providerForgotPassword(email);
  }
}
