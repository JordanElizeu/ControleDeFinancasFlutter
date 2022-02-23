import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../string_i18n.dart';

class ProviderInformationOfUser {
  final RepositoryConnection repositoryConnection;

  ProviderInformationOfUser({required this.repositoryConnection});

  Future<String?> providerGetNameIfUserIsFromFirebase() async {
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    if (auth.currentUser != null) {
      DatabaseReference _databaseReference = FirebaseDatabase.instance
          .ref('$pathAppFinances/${auth.currentUser!.uid}/$pathAccount');
      DatabaseEvent event = await _databaseReference.once();
      final String name = event.snapshot.child(columnName).value.toString();
      return name;
    }
    return null;
  }
}
