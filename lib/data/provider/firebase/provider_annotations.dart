import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ProviderAnnotations {
  final uuid = Uuid().v4();
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void providerSendAnnotation(
      {required String title, required String annotation, required BuildContext context}) {
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(uuid)
        .child('annotation')
        .set(annotation);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(uuid)
        .child('title')
        .set(title);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(uuid)
        .child('uid')
        .set(uuid);
  }

  void providerRemoveAnnotation() {}

  Future<Map> providerGetAllAnnotations() async {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('AppFinancas/${_auth.currentUser!.uid}/Account/Annotations');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value as Map;
  }
}
