import 'package:app_financeiro/data/model/model_annotation/annotation_model.dart';
import 'package:app_financeiro/data/model/model_annotation/edit_annotation_model.dart';
import 'package:app_financeiro/data/provider/firebase/provider_annotation.dart';
import 'package:app_financeiro/injection/injection.dart';

class RepositoryAnnotations {
  final ProviderAnnotations _providerAnnotations =
      getIt.get<ProviderAnnotations>();

  Future<void> repositorySendAnnotation(
      {required AnnotationModel modelAnnotation}) async {
    await _providerAnnotations.providerSendAnnotation(
        modelAnnotation: modelAnnotation);
  }

  Future<Map<dynamic, dynamic>> repositoryGetAllAnnotations() {
    return _providerAnnotations.providerGetAllAnnotations();
  }

  Future<void> editAnnotation(
      {required EditAnnotationModel editAnnotationModel}) async {
    await _providerAnnotations.providerEditAnnotation(
        editAnnotationModel: editAnnotationModel);
  }

  Future<void> removeAnnotation({required String id}) async {
    await _providerAnnotations.providerRemoveAnnotation(uid: id);
  }
}
