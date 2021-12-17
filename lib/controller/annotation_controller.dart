import 'package:app_financeiro/data/repository/firebase/repository_annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AnnotationsController extends GetxController {
  static Map<dynamic, dynamic> map = {};

  static TextEditingController textEditingControllerTitle =
      TextEditingController();
  static TextEditingController textEditingControllerAnnotation =
      TextEditingController();
  static GlobalKey<FormState> formKeyFieldAnnotationTitle =
      GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldAnnotation = GlobalKey<FormState>();

  Future<bool> sendAnnotation({required BuildContext context}) async {
    final FormState? formValidateTitle =
        formKeyFieldAnnotationTitle.currentState;
    final FormState? formValidateAnnotation =
        formKeyFieldAnnotation.currentState;
    if (formValidateTitle!.validate() && formValidateAnnotation!.validate()) {
      RepositoryAnnotations().repositorySendAnnotation(
          title: textEditingControllerTitle.text,
          annotation: textEditingControllerAnnotation.text,
          context: context);
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
    AnnotationsController.map =
        await RepositoryAnnotations().repositoryGetAllAnnotations();
    return AnnotationsController.map;
  }

  String? validateFieldFormTextTitle(text) {
    if (text.isEmpty) {
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

  void removeAnnotation({required String uid, required BuildContext context}) {
    RepositoryAnnotations().removeAnnotation(uid: uid);
  }

  void editAnnotation(
      {required String uid,
      required BuildContext context,
      required int index}) {
    AnnotationsController.map[index] = {
      0: textEditingControllerTitle.text,
      1: textEditingControllerAnnotation.text
    };
    RepositoryAnnotations().editAnnotation(uid: uid, context: context);
    update();
  }

  void recoverAnnotation({required Map<dynamic, dynamic> map}) async {
    AnnotationsController.map.addAll(map);
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
