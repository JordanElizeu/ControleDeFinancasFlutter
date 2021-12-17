import 'package:app_financeiro/data/provider/firebase/provider_annotations.dart';
import 'package:flutter/cupertino.dart';

class RepositoryAnnotations {
  void repositorySendAnnotation(
      {required String title,
      required String annotation,
      required BuildContext context}) {
    ProviderAnnotations().providerSendAnnotation(
        title: title, annotation: annotation, context: context);
  }

  Future<Map<dynamic,dynamic>> repositoryGetAllAnnotations() {
    return ProviderAnnotations().providerGetAllAnnotations();
  }

  void editAnnotation({required String uid, required BuildContext context}) {
    ProviderAnnotations().providerEditAnnotation(uid: uid, context: context);
  }

  void removeAnnotation({required String uid}) {
    ProviderAnnotations().providerRemoveAnnotation(uid: uid);
  }
}
