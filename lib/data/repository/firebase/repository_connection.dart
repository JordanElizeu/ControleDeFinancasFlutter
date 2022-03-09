import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RepositoryConnection {
  DatabaseReference? _databaseReference;

  DatabaseReference connectionDatabase() {
    if (_databaseReference != null) {
      return _databaseReference!;
    }
    _databaseReference = FirebaseDatabase.instance.ref();
    return _databaseReference!;
  }

  FirebaseAuth connectionFirebaseAuth() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth;
  }

  void repositoryConnectionLogout() {
    _databaseReference = null;
  }
}
