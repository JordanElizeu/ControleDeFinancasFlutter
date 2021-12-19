import 'package:app_financeiro/data/model/model_annotation/model_annotation.dart';
import 'package:app_financeiro/data/model/model_annotation/model_editannotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProviderAnnotations {

  final DatabaseReference _databaseReference;
  final FirebaseAuth _auth;

  ProviderAnnotations(this._databaseReference, this._auth);

  void providerSendAnnotation(
      {required ModelAnnotation modelAnnotation}) async {
    final String id = await _getLengthAnnotation();
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(id)
        .child('annotation')
        .set(modelAnnotation.annotation);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(id)
        .child('title')
        .set(modelAnnotation.titleAnnotation);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(id)
        .child('uid')
        .set(id);
  }

  Future<String> _getLengthAnnotation() async {
    String lengthAnnotation = '';
    await providerGetAllAnnotations().then((value) => {
      lengthAnnotation = "${value.length.toString()}a"
    });
    return lengthAnnotation;
  }

  void providerEditAnnotation(
      {required ModelEditAnnotation modelEditAnnotation}) {
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(modelEditAnnotation.id)
        .child('annotation')
        .set(modelEditAnnotation.annotation);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(modelEditAnnotation.id)
        .child('title')
        .set(modelEditAnnotation.titleAnnotation);
    _databaseReference
        .child('AppFinancas')
        .child(_auth.currentUser!.uid)
        .child('Account')
        .child('Annotations')
        .child(modelEditAnnotation.id)
        .child('uid')
        .set(modelEditAnnotation.id);
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
