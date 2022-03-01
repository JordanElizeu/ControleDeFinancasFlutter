import 'package:app_financeiro/data/model/financial_rent_model/financial_rent_model.dart';
import 'package:flutter/cupertino.dart';

class EditRentModel extends FinancialRentModel {
  final String id;

  EditRentModel(
      {required String title,
      required this.id,
      required String description,
      required String valueMoney,
      required BuildContext context})
      : super(
          title: title,
          description: description,
          context: context,
          valueMoney: valueMoney,
        );
}
