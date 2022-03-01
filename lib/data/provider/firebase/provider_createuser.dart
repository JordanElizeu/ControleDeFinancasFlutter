import 'package:app_financeiro/data/model/login_model/create_user_model.dart';
import 'package:app_financeiro/data/provider/firebase_exceptions/firebase_exceptions.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../string_i18n.dart';

class ProviderCreateUser {
  final RepositoryConnection repositoryConnection;

  ProviderCreateUser({required this.repositoryConnection});

  Future<String?> providerCreateFirebaseUser(
      {required CreateUserModel modelCreateUser}) async {
    try {
      final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
      final DatabaseReference databaseReference =
          repositoryConnection.connectionDatabase();
      await auth.createUserWithEmailAndPassword(
          email: modelCreateUser.email, password: modelCreateUser.password);
      databaseReference
          .child(pathAppFinances)
          .child(auth.currentUser!.uid)
          .child(pathAccount)
          .child(columnName)
          .set(modelCreateUser.name);
      databaseReference
          .child(pathAppFinances)
          .child(auth.currentUser!.uid)
          .child(pathAccount)
          .child(pathFinances)
          .child(columnMoney)
          .set('0');
    } on FirebaseAuthException catch (exception) {
      return ProviderFirebaseExceptions()
          .handleFirebaseCreateUserWithEmailAndPasswordException(
              exceptionMessage: exception);
    }
    return null;
  }

  Future<void> providerCreateUserGoogle() async {
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    repositoryConnection
        .connectionDatabase()
        .child(pathAppFinances)
        .child(auth.currentUser!.uid)
        .child(pathAccount)
        .child(columnName)
        .set(auth.currentUser!.displayName);
  }
}
