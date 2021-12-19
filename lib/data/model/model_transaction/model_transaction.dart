import 'package:flutter/cupertino.dart';

class ModelTransaction {
  final String _title;
  final String _description;
  final BuildContext _context;
  final double _quantityMoney;
  final bool isDeposit;

  ModelTransaction(
      this._title, this._description, this._context, this._quantityMoney,
      {required this.isDeposit});

  double get quantityMoney => _quantityMoney;

  BuildContext get context => _context;

  String get description => _description;

  String get title => _title;
}
