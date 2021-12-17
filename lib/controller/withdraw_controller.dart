import 'package:app_financeiro/data/repository/firebase/repository_withdraw.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'controller.dart';

class WithdrawMoneyController extends GetxController {
  final TextEditingController textEditingControllerWithdrawMoney =
      TextEditingController();
  final TextEditingController textEditingControllerWithdrawTitle =
      TextEditingController();
  final TextEditingController textEditingControllerWithdrawDesc =
      TextEditingController();
  final GlobalKey<FormState> formKeyFieldWithdrawTitle = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyFieldWithdrawDesc = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyFieldWithdrawMoney = GlobalKey<FormState>();

  Future<void> confirmMoneyWithdraw({required BuildContext context}) async {
    final FormState? formValidateTitle = formKeyFieldWithdrawTitle.currentState;
    final FormState? formValidateDesc = formKeyFieldWithdrawDesc.currentState;
    final FormState? formValidateMoney = formKeyFieldWithdrawMoney.currentState;

    if (formValidateTitle!.validate() &&
        formValidateDesc!.validate() &&
        formValidateMoney!.validate()) {
      double moneyWithdraw = double.parse(formatMoneyValueInField());
      await RepositoryWithdraw().repositoryMoneyWithdraw(
          context: context,
          title: textEditingControllerWithdrawTitle.text,
          description: textEditingControllerWithdrawDesc.text,
          moneyWithdraw: moneyWithdraw);
    }
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

  void clearFields() {
    formKeyFieldWithdrawTitle.currentState!.reset();
    formKeyFieldWithdrawDesc.currentState!.reset();
    formKeyFieldWithdrawMoney.currentState!.reset();
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
