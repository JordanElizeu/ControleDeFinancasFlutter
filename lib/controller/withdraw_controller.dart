import 'package:app_financeiro/data/repository/firebase/repository_transactions.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'controller.dart';

class WithdrawMoneyController extends GetxController {
  TextEditingController textEditingControllerWithdrawMoney =
      TextEditingController();
  TextEditingController textEditingControllerWithdrawTitle =
      TextEditingController();
  TextEditingController textEditingControllerWithdrawDesc =
      TextEditingController();
  GlobalKey<FormState> formKeyFieldWithdrawTitle = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyFieldWithdrawDesc = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyFieldWithdrawMoney = GlobalKey<FormState>();

  Future<bool?> confirmMoneyWithdraw({required BuildContext context}) async {
    final FormState? formValidateTitle = formKeyFieldWithdrawTitle.currentState;
    final FormState? formValidateDesc = formKeyFieldWithdrawDesc.currentState;
    final FormState? formValidateMoney = formKeyFieldWithdrawMoney.currentState;

    if (formValidateTitle!.validate() &&
        formValidateDesc!.validate() &&
        formValidateMoney!.validate()) {
      double moneyWithdraw = double.parse(formatMoneyValueInField());
      return await RepositoryTransactions().repositoryMoneyWithdraw(
          context: context,
          title: textEditingControllerWithdrawTitle.text,
          description: textEditingControllerWithdrawDesc.text,
          value: moneyWithdraw);
    }
  }

  void clearFields({required BuildContext context}) {
    textEditingControllerWithdrawMoney.text = '';
    textEditingControllerWithdrawTitle.text = '';
    textEditingControllerWithdrawDesc.text = '';
    Controller().pageTransition(route: Routes.HOME, context: context);
    update();
  }

  String? validateFieldFormTextMoney() {
    if (!_validateValueMoney()) {
      return 'Preencha um valor correto';
    }
    return null;
  }

  String? validateFieldFormTextTitle() {
    if (textEditingControllerWithdrawTitle.text.isEmpty) {
      return 'Preencha um título';
    }
    return null;
  }

  String? validateFieldFormTextDesc() {
    if (textEditingControllerWithdrawDesc.text.isEmpty) {
      return 'Preencha uma descrição';
    }
    return null;
  }

  String formatMoneyValueInField() {
    String formatToString = textEditingControllerWithdrawMoney.text
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

  @override
  void dispose() {
    super.dispose();
  }
}
