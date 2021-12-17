import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'controller.dart';

class DepositMoneyController extends GetxController {

  static TextEditingController textEditingControllerDepositMoney =
      TextEditingController();
  static TextEditingController textEditingControllerDepositTitle =
      TextEditingController();
  static TextEditingController textEditingControllerDepositDesc =
      TextEditingController();
  static GlobalKey<FormState> formKeyFieldDepositTitle = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldDepositDesc = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldDepositMoney = GlobalKey<FormState>();

  Future<bool?> confirmDeposit({required BuildContext context}) async{
    final FormState? formValidateTitle = formKeyFieldDepositTitle.currentState;
    final FormState? formValidateDesc = formKeyFieldDepositDesc.currentState;
    final FormState? formValidateMoney = formKeyFieldDepositMoney.currentState;
    if (formValidateTitle!.validate() &&
        formValidateDesc!.validate() &&
        formValidateMoney!.validate()) {
      return await RepositoryTransactions().repositoryDepositMoney(
          quantityMoney: double.parse(_formatValueMoney()),
          desc: textEditingControllerDepositDesc.text,
          title: textEditingControllerDepositTitle.text,context: context);
    }
  }

  void clearFields({required BuildContext context}) {
    textEditingControllerDepositMoney.text = '';
    textEditingControllerDepositTitle.text = '';
    textEditingControllerDepositDesc.text = '';
    Controller().pageTransition(route: Routes.HOME, context: context,);
    update();
  }

  String? validateFieldFormTextMoney() {
    if (!_validateValueMoney()) {
      return 'Preencha um valor correto';
    }
    return null;
  }

  String? validateFieldFormTextTitle() {
    if (textEditingControllerDepositTitle.text.isEmpty) {
      return 'Preencha um título';
    }
    return null;
  }

  String? validateFieldFormTextDesc() {
    if (textEditingControllerDepositDesc.text.isEmpty) {
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
    return textEditingControllerDepositMoney.text
        .replaceAll(' ', '')
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
