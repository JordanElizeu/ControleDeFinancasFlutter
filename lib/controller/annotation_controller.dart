import 'package:app_financeiro/data/model/model_annotation/annotation_model.dart';
import 'package:app_financeiro/data/model/model_annotation/edit_annotation_model.dart';
import 'package:app_financeiro/data/repository/firebase/repository_annotations.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AnnotationsController extends GetxController {
  Map<dynamic, dynamic> map = {};

  final TextEditingController textEditingControllerTitle =
      TextEditingController();
  final TextEditingController textEditingControllerAnnotation =
      TextEditingController();
  final RepositoryAnnotations _repositoryAnnotations =
      getIt.get<RepositoryAnnotations>();
  static bool checkBoxSelected = false;

  Future<bool> sendAnnotation(
      {required BuildContext context,
      required String title,
      required GlobalKey<FormState> formKeyAnnotation,
      required GlobalKey<FormState> formKeyTitle,
      required String annotation}) async {
    final FormState? formValidateTitle = formKeyTitle.currentState;
    final FormState? formValidateAnnotation = formKeyAnnotation.currentState;
    if (formValidateTitle!.validate() && formValidateAnnotation!.validate()) {
      _repositoryAnnotations.repositorySendAnnotation(
          modelAnnotation: AnnotationModel(annotation, title, context));
      await Future.delayed(Duration(milliseconds: 300)).then((value) async => {
            await getAllAnnotations(),
            clearFields(context: context),
            update(),
          });
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
    map = await _repositoryAnnotations.repositoryGetAllAnnotations();
    return map;
  }

  void changeCheckBoxSelected(bool value) {
    checkBoxSelected = value;
    update();
  }

  Future<void> removeAnnotation(
      {required String id, required BuildContext context}) async {
    await _repositoryAnnotations.removeAnnotation(id: id);
    update();
  }

  Future<void> editAnnotation(
      {required String id,
      required BuildContext context,
      required int index}) async {
    map[index] = {
      0: textEditingControllerTitle.text,
      1: textEditingControllerAnnotation.text
    };
    await _repositoryAnnotations.editAnnotation(
        editAnnotationModel: EditAnnotationModel(
            textEditingControllerAnnotation.text,
            textEditingControllerTitle.text,
            context,
            id));
    clearFields(context: context);
    update();
  }

  void recoverAnnotation({required Map<dynamic, dynamic> map}) async {
    this.map.addAll(map);
    update();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingControllerTitle.dispose();
    textEditingControllerAnnotation.dispose();
  }
}
