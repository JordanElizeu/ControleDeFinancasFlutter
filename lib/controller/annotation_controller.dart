import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AnnotationsController extends GetxController{
  static TextEditingController textEditingControllerTitle =
  TextEditingController();
  static TextEditingController textEditingControllerAnnotation =
  TextEditingController();
  static GlobalKey<FormState> formKeyFieldTitle = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldAnnotation = GlobalKey<FormState>();

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