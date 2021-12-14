import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DepositMoneyController extends GetxController {
  static TextEditingController textEditingControllerMoney =
      TextEditingController();
  static TextEditingController textEditingControllerTitle =
      TextEditingController();
  static TextEditingController textEditingControllerDesc =
      TextEditingController();
  static GlobalKey<FormState> formKeyFieldTitle = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldDesc = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldMoney = GlobalKey<FormState>();

  Future<bool?> confirmDeposit(BuildContext context) async{
    final FormState? formValidateTitle = formKeyFieldTitle.currentState;
    final FormState? formValidateDesc = formKeyFieldDesc.currentState;
    final FormState? formValidateMoney = formKeyFieldMoney.currentState;
    if (formValidateTitle!.validate() &&
        formValidateDesc!.validate() &&
        formValidateMoney!.validate()) {
      return await RepositoryTransactions(context).depositMoney(
          quantityMoney: double.parse(_formatValueMoney()),
          desc: textEditingControllerDesc.text,
          title: textEditingControllerTitle.text);
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
