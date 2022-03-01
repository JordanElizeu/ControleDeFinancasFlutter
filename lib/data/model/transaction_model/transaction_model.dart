import 'package:flutter/cupertino.dart';

class TransactionModel {
  final String title;
  final String description;
  final BuildContext context;
  final double quantityMoney;
  final bool isDeposit;
  final String textSelectRent;

  TransactionModel({
    required this.title,
    required this.description,
    required this.context,
    required this.quantityMoney,
    required this.textSelectRent,
    required this.isDeposit,
  });
}
