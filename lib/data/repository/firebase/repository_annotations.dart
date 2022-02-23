import 'package:app_financeiro/data/model/model_annotation/model_annotation.dart';
import 'package:app_financeiro/data/model/model_annotation/model_editannotation.dart';
import 'package:app_financeiro/data/provider/firebase/provider_annotation.dart';
import 'package:app_financeiro/injection/injection.dart';

class RepositoryAnnotations {
  final ProviderAnnotations _providerAnnotations =
      getIt.get<ProviderAnnotations>();

  Future<void> repositorySendAnnotation(
      {required ModelAnnotation modelAnnotation}) async {
    await _providerAnnotations.providerSendAnnotation(
        modelAnnotation: modelAnnotation);
  }

  Future<Map<dynamic, dynamic>> repositoryGetAllAnnotations() {
    return _providerAnnotations.providerGetAllAnnotations();
  }

  Future<void> editAnnotation(
      {required ModelEditAnnotation modelEditAnnotation}) async {
    await _providerAnnotations.providerEditAnnotation(
        modelEditAnnotation: modelEditAnnotation);
  }

  Future<void> removeAnnotation({required String id}) async {
    await _providerAnnotations.providerRemoveAnnotation(uid: id);
  }
}
