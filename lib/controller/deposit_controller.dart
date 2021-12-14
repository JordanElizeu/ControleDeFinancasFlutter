import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DepositMoneyController extends GetxController {

  final BuildContext _context;

  DepositMoneyController(this._context);

  static TextEditingController textEditingControllerMoney =
      TextEditingController();
  static TextEditingController textEditingControllerTitle =
      TextEditingController();
  static TextEditingController textEditingControllerDesc =
      TextEditingController();
  static GlobalKey<FormState> formKeyFieldTitle = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldDesc = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldMoney = GlobalKey<FormState>();

  Future<bool?> confirmDeposit() async{
    final FormState? formValidateTitle = formKeyFieldTitle.currentState;
    final FormState? formValidateDesc = formKeyFieldDesc.currentState;
    final FormState? formValidateMoney = formKeyFieldMoney.currentState;
    if (formValidateTitle!.validate() &&
        formValidateDesc!.validate() &&
        formValidateMoney!.validate()) {
      return await RepositoryTransactions(_context).repositoryDepositMoney(
          quantityMoney: double.parse(_formatValueMoney()),
          desc: textEditingControllerDesc.text,
          title: textEditingControllerTitle.text);
    }
  }

  void clearFields() {
    textEditingControllerMoney.text = '';
    textEditingControllerTitle.text = '';
    textEditingControllerDesc.text = '';
    Controller(_context).pageTransition(route: Routes.HOME);
    update();
  }

  String? validateFieldFormTextMoney() {
    if (!_validateValueMoney()) {
      return 'Preencha um valor correto';
    }
    return null;
  }

  String? validateFieldFormTextTitle() {
    if (textEditingControllerTitle.text.isEmpty) {
      return 'Preencha um título';
    }
    return null;
  }

  String? validateFieldFormTextDesc() {
    if (textEditingControllerDesc.text.isEmpty) {
      return 'Preencha uma descrição';
    }
    return null;
  }

  bool _validateValueMoney() {
    String formatToString = _formatValueMoney();
    final double formatToDouble = double.parse(formatToString);
    if (formatToDouble <= 0.0) {
      return false;
    }
    return true;
  }

  String _formatValueMoney() {
    return textEditingControllerMoney.text
        .replaceAll(' ', '')
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
  }
}
