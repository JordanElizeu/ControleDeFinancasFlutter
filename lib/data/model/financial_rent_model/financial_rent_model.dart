import 'package:flutter/cupertino.dart';

class FinancialRentModel {
  final String title;
  final String description;
  final String valueMoney;
  final BuildContext context;

  FinancialRentModel({
    required this.title,
    required this.description,
    required this.context,
    required this.valueMoney,
  });
}
