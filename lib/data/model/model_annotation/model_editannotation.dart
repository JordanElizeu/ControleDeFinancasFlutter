import 'package:app_financeiro/data/model/model_annotation/model_annotation.dart';
import 'package:flutter/cupertino.dart';

class ModelEditAnnotation extends ModelAnnotation {
  final String _id;

  ModelEditAnnotation(
      String annotation, String titleAnnotation, BuildContext context, this._id)
      : super(annotation, titleAnnotation, context);

  String get id => _id;
}
