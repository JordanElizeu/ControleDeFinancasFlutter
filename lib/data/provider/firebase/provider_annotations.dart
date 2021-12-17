import 'package:app_financeiro/controller/annotation_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ProviderAnnotations {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void providerSendAnnotation(
      {required String title,
      required String annotation,
      required BuildContext context}) async {
    final map = await providerGetAllAnnotations();
    final String id = '${map.length}a';
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(id)
        .child('annotation')
        .set(annotation);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(id)
        .child('title')
        .set(title);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(id)
        .child('uid')
        .set(id);
    AnnotationsController().clearFields(context: context);
  }

  void providerEditAnnotation(
      {required String uid,
      required BuildContext context,
      required String annotation,
      required String title}) {
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(uid)
        .child('annotation')
        .set(annotation);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(uid)
        .child('title')
        .set(title);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(uid)
        .child('uid')
        .set(uid);
    AnnotationsController().clearFields(context: context);
  }

  void providerRemoveAnnotation({required String uid}) {
    final DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref('AppFinancas/${_auth.currentUser!.uid}/Account/Annotations/$uid');
    databaseReference.remove();
  }

  Future<Map<dynamic, dynamic>> providerGetAllAnnotations() async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref('AppFinancas/${_auth.currentUser!.uid}/Account/Annotations');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value != null ? event.snapshot.value as Map : {};
  }
}
