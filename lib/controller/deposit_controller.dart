import 'package:app_financeiro/controller/home_controller.dart';
import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/repository/firebase/repository_deposit.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../utils/transition_page.dart';

class DepositMoneyController extends GetxController {
  final TextEditingController textEditingControllerDepositMoney =
      TextEditingController();
  final TextEditingController textEditingControllerDepositTitle =
      TextEditingController();
  final TextEditingController textEditingControllerDepositDesc =
      TextEditingController();

  final RepositoryDeposit _repositoryDeposit = getIt.get<RepositoryDeposit>();
  final TransitionPage _transitionController =
      getIt.get<TransitionPage>();

  Future<void> confirmDeposit({
    required BuildContext context,
    required GlobalKey<FormState> formKeyTitle,
    required GlobalKey<FormState> formKeyMoney,
    required GlobalKey<FormState> formKeyDesc,
  }) async {
    final FormState? formValidateTitle = formKeyTitle.currentState;
    final FormState? formValidateDesc = formKeyDesc.currentState;
    final FormState? formValidateMoney = formKeyMoney.currentState;
    if (formValidateTitle!.validate() &&
        formValidateDesc!.validate() &&
        formValidateMoney!.validate()) {
      double valueAvailable;
      double newValue;
      bool result = await _repositoryDeposit.repositoryAddDeposit(
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
        await _transitionController.finishAndPageTransition(
            route: Routes.HOME, context: context);
      }
    }
  }

  void clearAllFields() {
    textEditingControllerDepositTitle.text = '';
    textEditingControllerDepositDesc.text = '';
    textEditingControllerDepositMoney.text = '';
    update();
  }

  bool _validateValueMoney(text) {
    String formatToString = _formatValueMoney();
    final double formatToDouble = double.parse(formatToString);
    if (formatToDouble <= 0.0) {
      return false;
    }
    return true;
  }

  String? validateFieldFormTextMoney(text) {
    if (!_validateValueMoney(text)) {
      return 'Preencha um valor correto';
    }
    return null;
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
    textEditingControllerDepositMoney.dispose();
    textEditingControllerDepositTitle.dispose();
    textEditingControllerDepositDesc.dispose();
  }
}
