import 'package:app_financeiro/data/model/model_annotation/model_annotation.dart';
import 'package:app_financeiro/data/model/model_annotation/model_editannotation.dart';
import 'package:app_financeiro/data/provider/firebase/provider_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
final FirebaseAuth _auth = FirebaseAuth.instance;

class RepositoryAnnotations {

  final ProviderAnnotations _providerAnnotations = ProviderAnnotations(_databaseReference,_auth);

  void repositorySendAnnotation(
      {required ModelAnnotation modelAnnotation}) {
    _providerAnnotations.providerSendAnnotation(modelAnnotation: modelAnnotation);
  }

  Future<Map<dynamic, dynamic>> repositoryGetAllAnnotations() {
    return _providerAnnotations.providerGetAllAnnotations();
  }

  void editAnnotation(
      {required ModelEditAnnotation modelEditAnnotation}) {
    _providerAnnotations.providerEditAnnotation(modelEditAnnotation: modelEditAnnotation);
  }

  void removeAnnotation({required String id}) {
    _providerAnnotations.providerRemoveAnnotation(uid: id);
  }
}
