import 'package:app_financeiro/data/model/model_annotation/annotation_model.dart';
import 'package:flutter/cupertino.dart';

class EditAnnotationModel extends AnnotationModel {
  final String _id;

  EditAnnotationModel(
      String annotation, String titleAnnotation, BuildContext context, this._id)
      : super(annotation, titleAnnotation, context);

  String get id => _id;
}
