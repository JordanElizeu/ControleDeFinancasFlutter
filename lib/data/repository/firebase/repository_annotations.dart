import 'package:app_financeiro/data/model/model_annotation/model_annotation.dart';
import 'package:app_financeiro/data/model/model_annotation/model_editannotation.dart';
import 'package:app_financeiro/data/provider/firebase/provider_createannotation.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';

class RepositoryAnnotations {
  final ProviderAnnotations _providerAnnotations = ProviderAnnotations(
      RepositoryConnection.connectionDatabase(),
      RepositoryConnection.connectionFirebaseAuth());

  void repositorySendAnnotation({required ModelAnnotation modelAnnotation}) {
    _providerAnnotations.providerSendAnnotation(
        modelAnnotation: modelAnnotation);
  }

  Future<Map<dynamic, dynamic>> repositoryGetAllAnnotations() {
    return _providerAnnotations.providerGetAllAnnotations();
  }

  void editAnnotation({required ModelEditAnnotation modelEditAnnotation}) {
    _providerAnnotations.providerEditAnnotation(
        modelEditAnnotation: modelEditAnnotation);
  }

  void removeAnnotation({required String id}) {
    _providerAnnotations.providerRemoveAnnotation(uid: id);
  }
}
