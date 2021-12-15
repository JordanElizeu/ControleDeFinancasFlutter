import 'package:app_financeiro/data/repository/firebase/repository_annotations.dart';
import 'package:app_financeiro/ui/annotations/widgets/widget_createannotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AnnotationsController extends GetxController {
  Map<dynamic,dynamic> map = {};
  Map<dynamic,dynamic> mapBackup = {};

  static TextEditingController textEditingControllerTitle =
      TextEditingController();
  static TextEditingController textEditingControllerAnnotation =
      TextEditingController();
  static GlobalKey<FormState> formKeyFieldTitle = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldAnnotation = GlobalKey<FormState>();

  void sendAnnotation({required BuildContext context}) {
    final FormState? formValidateTitle = formKeyFieldTitle.currentState;
    final FormState? formValidateAnnotation =
        formKeyFieldAnnotation.currentState;
    if (formValidateTitle!.validate() && formValidateAnnotation!.validate()) {
      RepositoryAnnotations().repositorySendAnnotation(
          title: textEditingControllerTitle.text,
          annotation: textEditingControllerAnnotation.text, context: context);
    }
  }

  void clearFields({required BuildContext context}) async{
    textEditingControllerTitle.text = '';
    textEditingControllerAnnotation.text = '';
    update();
  }

  Future<Map<dynamic,dynamic>> getAllAnnotations({required BuildContext context}) async{
    map = await RepositoryAnnotations().repositoryGetAllAnnotations();
    return map;
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
    mapBackup = map;
    update();
  }

  Map<dynamic,dynamic>? getBackupMap(){
    return mapBackup;
  }

  void removeAnnotation({required String uid,required BuildContext context}){
    RepositoryAnnotations().removeAnnotation(uid: uid);
  }

  void editAnnotation({required String uid,required BuildContext context,required int index}){
    map[index] = {
      0: textEditingControllerTitle.text,
      1: textEditingControllerAnnotation.text
    };
    RepositoryAnnotations().editAnnotation(uid: uid, context: context);
    update();
  }

  void recoverAnnotation({required Map<dynamic,dynamic> map, required BuildContext context}){
    this.map.addAll(map);
    RepositoryAnnotations().repositorySendAnnotation(
        title: map['title'],
        annotation: map['annotation'], context: context);
    update();
  }
}
