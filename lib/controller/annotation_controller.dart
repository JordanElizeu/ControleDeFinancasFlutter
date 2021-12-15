import 'package:app_financeiro/data/repository/firebase/repository_annotations.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AnnotationsController extends GetxController {
  final BuildContext context;
  static Map<dynamic,dynamic>? _map;

  AnnotationsController({required this.context});

  static TextEditingController textEditingControllerTitle =
      TextEditingController();
  static TextEditingController textEditingControllerAnnotation =
      TextEditingController();
  static GlobalKey<FormState> formKeyFieldTitle = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldAnnotation = GlobalKey<FormState>();

  void sendAnnotation() {
    final FormState? formValidateTitle = formKeyFieldTitle.currentState;
    final FormState? formValidateAnnotation =
        formKeyFieldAnnotation.currentState;
    if (formValidateTitle!.validate() && formValidateAnnotation!.validate()) {
      RepositoryAnnotations(context: context).repositorySendAnnotation(
          title: textEditingControllerTitle.text,
          annotation: textEditingControllerAnnotation.text);
    }
  }

  void clearFields(){
    textEditingControllerTitle.text = '';
    textEditingControllerAnnotation.text = '';
    Controller(context).finishAndPageTransition(route: Routes.ANNOTATIONS);
    update();
  }

  Future<Map<dynamic,dynamic>> getAllAnnotations() async{
    return RepositoryAnnotations(context: context).repositoryGetAllAnnotations();
  }

  String? validateFieldFormTextTitle() {
    if (textEditingControllerTitle.text.isEmpty) {
      return 'Preencha um título';
    }
    return null;
  }

  String? validateFieldFormTextAnnotation() {
    if (textEditingControllerAnnotation.text.isEmpty) {
      return 'Preencha uma anotação';
    }
    return null;
  }

  void saveBackupMap(Map<dynamic,dynamic> map){
    _map = map;
    update();
  }

  void removeAnnotation({required String uid}){
    RepositoryAnnotations(context: context).removeAnnotation(uid: uid);
  }

  void editAnnotation({required String uid}){
    RepositoryAnnotations(context: context).editAnnotation(uid: uid);
  }

  void recoverAnnotation(Map<dynamic,dynamic> map){
    RepositoryAnnotations(context: context).repositorySendAnnotation(
        title: map['title'],
        annotation: map['annotation']);
  }

  Map<dynamic,dynamic>? getBackupMap(){
    return _map;
  }
}
