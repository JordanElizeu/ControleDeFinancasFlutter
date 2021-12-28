import 'package:app_financeiro/controller/home_controller.dart';
import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/repository/firebase/repository_deposit.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'transition_controller.dart';

class DepositMoneyController extends GetxController {
  static TextEditingController textEditingControllerDepositMoney =
      TextEditingController();
  static TextEditingController textEditingControllerDepositTitle =
      TextEditingController();
  static TextEditingController textEditingControllerDepositDesc =
      TextEditingController();
  final GlobalKey<FormState> formKeyFieldDepositTitle = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyFieldDepositDesc = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyFieldDepositMoney = GlobalKey<FormState>();

  Future<void> confirmDeposit({required BuildContext context}) async {
    final FormState? formValidateTitle = formKeyFieldDepositTitle.currentState;
    final FormState? formValidateDesc = formKeyFieldDepositDesc.currentState;
    final FormState? formValidateMoney = formKeyFieldDepositMoney.currentState;
    if (formValidateTitle!.validate() &&
        formValidateDesc!.validate() &&
        formValidateMoney!.validate()) {
      double valueAvailable;
      double newValue;
      bool result = await RepositoryDeposit().repositoryAddDeposit(
        modelTransaction: ModelTransaction(
            textEditingControllerDepositTitle.text,
            textEditingControllerDepositDesc.text,
            context,
            double.parse(_formatValueMoney()),
            isDeposit: true),
      );
      if (result) {
        valueAvailable = double.parse(HomeController.moneyValue);
        newValue = double.parse(_formatValueMoney());
        HomeController.moneyValue = (valueAvailable + newValue).toString();
        clearAllFields();
        await TransitionController()
            .pageTransition(route: Routes.HOME, context: context);
      }
    }
  }

  void clearAllFields() {
    textEditingControllerDepositTitle.text = '';
    textEditingControllerDepositDesc.text = '';
    textEditingControllerDepositMoney.text = '';
    update();
  }

  String? validateFieldFormTextMoney(text) {
    if (!_validateValueMoney(text)) {
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

  bool _validateValueMoney(text) {
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
    textEditingControllerDepositMoney.dispose();
    textEditingControllerDepositTitle.dispose();
    textEditingControllerDepositDesc.dispose();
    super.dispose();
  }
}
