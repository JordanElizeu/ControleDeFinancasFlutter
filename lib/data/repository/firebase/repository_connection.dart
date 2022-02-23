import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RepositoryConnection {
  DatabaseReference? _databaseReference;
  FirebaseAuth? _auth;

  DatabaseReference connectionDatabase() {
    if (_databaseReference != null) {
      return _databaseReference!;
    }
    _databaseReference = FirebaseDatabase.instance.ref();
    return _databaseReference!;
  }

  FirebaseAuth connectionFirebaseAuth() {
    if (_auth != null) {
      return _auth!;
    }
    _auth = FirebaseAuth.instance;
    return _auth!;
  }
}
