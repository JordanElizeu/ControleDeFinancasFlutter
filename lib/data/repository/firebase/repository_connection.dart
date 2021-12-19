import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RepositoryConnection{

  static DatabaseReference connectionDatabase(){
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    return databaseReference;
  }

  static FirebaseAuth connectionFirebaseAuth(){
    final FirebaseAuth auth = FirebaseAuth.instance;
    return auth;
  }
}