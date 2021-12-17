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
          title: title, annotation: annotation, context: context);
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

  void removeAnnotation({required String uid, required BuildContext context}) {
    RepositoryAnnotations().removeAnnotation(uid: uid);
  }

  void editAnnotation(
      {required String uid,
      required BuildContext context,
      required int index}) {
    map[index] = {
      0: textEditingControllerTitle.text,
      1: textEditingControllerAnnotation.text
    };
    RepositoryAnnotations().editAnnotation(
        uid: uid,
        context: context,
        annotation: textEditingControllerAnnotation.text,
        title: textEditingControllerTitle.text);
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
