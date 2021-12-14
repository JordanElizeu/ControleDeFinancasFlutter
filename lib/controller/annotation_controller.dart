import 'package:app_financeiro/data/repository/firebase/repository_annotations.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AnnotationsController extends GetxController {
  final BuildContext _context;

  AnnotationsController(this._context);

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
      RepositoryAnnotations(_context).repositorySendAnnotation(
          title: textEditingControllerTitle.text,
          annotation: textEditingControllerAnnotation.text);
    }
  }

  void clearFields(){
    textEditingControllerTitle.text = '';
    textEditingControllerAnnotation.text = '';
    Controller(_context).finishAndPageTransition(route: Routes.HOME);
    update();
  }

  Future<Map<dynamic,dynamic>> getAllAnnotations() async{
    return RepositoryAnnotations(_context).repositoryGetAllAnnotations();
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
}
