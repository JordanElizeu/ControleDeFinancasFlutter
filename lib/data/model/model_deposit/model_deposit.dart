import 'package:flutter/cupertino.dart';

class ModelDeposit{
  final String _title;
  final String _description;
  final BuildContext _context;
  final double _quantityMoney;

  ModelDeposit(
      this._title, this._description, this._context, this._quantityMoney);

  double get quantityMoney => _quantityMoney;

  BuildContext get context => _context;

  String get description => _description;

  String get title => _title;
}