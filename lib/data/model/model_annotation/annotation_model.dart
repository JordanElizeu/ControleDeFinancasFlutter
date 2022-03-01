import 'package:flutter/cupertino.dart';

class AnnotationModel {
  final String _annotation;
  final String _titleAnnotation;
  final BuildContext _context;

  AnnotationModel(this._annotation, this._titleAnnotation, this._context);

  BuildContext get context => _context;

  String get titleAnnotation => _titleAnnotation;

  String get annotation => _annotation;
}
