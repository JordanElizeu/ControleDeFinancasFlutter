import 'package:app_financeiro/data/model/model_annotation/model_annotation.dart';
import 'package:app_financeiro/data/model/model_annotation/model_editannotation.dart';
import 'package:app_financeiro/data/repository/firebase/repository_annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AnnotationsController extends GetxController {
  Map<dynamic, dynamic> map = {};

  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerAnnotation =
      TextEditingController();
  GlobalKey<FormState> formKeyFieldAnnotationTitle = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyFieldAnnotation = GlobalKey<FormState>();

  Future<bool> sendAnnotation(
      {required BuildContext context,
      required String title,
      required String annotation}) async {
    final FormState? formValidateTitle =
        formKeyFieldAnnotationTitle.currentState;
    final FormState? formValidateAnnotation =
        formKeyFieldAnnotation.currentState;
    if (formValidateTitle!.validate() && formValidateAnnotation!.validate()) {
      RepositoryAnnotations().repositorySendAnnotation(
          modelAnnotation: ModelAnnotation(annotation, title, context));
      await Future.delayed(Duration(milliseconds: 300))
          .then((value) async => {await getAllAnnotations(), update()});
      return true;
    }
    return false;
  }

  void clearFields({required BuildContext context}) async {
    textEditingControllerTitle.text = '';
    textEditingControllerAnnotation.text = '';
    update();
  }

  Future<Map<dynamic, dynamic>> getAllAnnotations() async {
    map = await RepositoryAnnotations().repositoryGetAllAnnotations();
    return map;
  }

  String? validateFieldFormTextTitle({required String text}) {
    if (text.isEmpty) {
      return 'Preencha um título';
    }
    return null;
  }

  String? validateFieldFormTextAnnotation({required String text}) {
    if (text.isEmpty) {
      return 'Preencha uma anotação';
    }
    return null;
  }

  void removeAnnotation({required String id, required BuildContext context}) {
    RepositoryAnnotations().removeAnnotation(id: id);
  }

  void editAnnotation(
      {required String id, required BuildContext context, required int index}) {
    map[index] = {
      0: textEditingControllerTitle.text,
      1: textEditingControllerAnnotation.text
    };
    RepositoryAnnotations().editAnnotation(
        modelEditAnnotation: ModelEditAnnotation(
            textEditingControllerAnnotation.text,
            textEditingControllerTitle.text,
            context,
            id));
    update();
  }

  void recoverAnnotation({required Map<dynamic, dynamic> map}) async {
    this.map.addAll(map);
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
