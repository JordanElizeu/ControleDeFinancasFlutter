import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WithdrawMoneyController extends GetxController {
  static TextEditingController textEditingControllerMoney =
      TextEditingController();
  static TextEditingController textEditingControllerTitle =
      TextEditingController();
  static TextEditingController textEditingControllerDesc =
      TextEditingController();
  static GlobalKey<FormState> formKeyFieldTitle = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldDesc = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldMoney = GlobalKey<FormState>();

  void confirmMoneyWithdraw(BuildContext context) {
    final FormState? formValidateTitle = formKeyFieldTitle.currentState;
    final FormState? formValidateDesc = formKeyFieldDesc.currentState;
    final FormState? formValidateMoney = formKeyFieldMoney.currentState;

    if (formValidateTitle!.validate() &&
        formValidateDesc!.validate() &&
        formValidateMoney!.validate()) {
      double moneyWithdraw = double.parse(formatMoneyValueInField());
      RepositoryTransactions().moneyWithdraw(moneyWithdraw, context);
    }
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

  String formatMoneyValueInField(){
    String formatToString = textEditingControllerMoney.text
        .replaceAll(' ', '')
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
    return formatToString;
  }

  bool _validateValueMoney() {
    final double formatToDouble = double.parse(formatMoneyValueInField());
    if (formatToDouble <= 0.0) {
      return false;
    }
    return true;
  }
}
