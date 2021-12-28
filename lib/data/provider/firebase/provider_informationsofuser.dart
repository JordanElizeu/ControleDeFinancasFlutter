import 'package:app_financeiro/data/provider/firebase_exceptions/firebase_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProviderInformationOfUser{

  final FirebaseAuth _auth;

  ProviderInformationOfUser(this._auth);

  Future<String?> providerGetNameIfUserIsFromFirebase() async {
    if(_auth.currentUser != null){
      DatabaseReference _databaseReference = FirebaseDatabase.instance
          .ref('AppFinancas/${_auth.currentUser!.uid}/Account');
      DatabaseEvent event = await _databaseReference.once();
      final String name = event.snapshot.child('name').value.toString();
      return name;
    }
    return null;
  }
}