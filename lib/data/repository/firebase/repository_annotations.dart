import 'package:app_financeiro/data/provider/firebase/provider_annotations.dart';
import 'package:flutter/cupertino.dart';

class RepositoryAnnotations{
  final BuildContext _context;

  RepositoryAnnotations(this._context);

  void repositorySendAnnotation({required String title, required String annotation}){
    ProviderAnnotations().providerSendAnnotation(title: title, annotation: annotation, context: _context);
  }

  Future<Map<dynamic,dynamic>> repositoryGetAllAnnotations(){
    return ProviderAnnotations().providerGetAllAnnotations();
  }
}