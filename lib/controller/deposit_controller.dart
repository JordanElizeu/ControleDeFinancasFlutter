import 'package:app_financeiro/data/model/transaction_model/transaction_model.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/injection/injection_depedencies.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../string_i18n.dart';
import '../utils/form_validation.dart';
import '../utils/transition_page.dart';

class DepositMoneyController extends GetxController {
  final TextEditingController textEditingControllerDepositMoney =
      TextEditingController();
  final TextEditingController textEditingControllerDepositTitle =
      TextEditingController();
  final TextEditingController textEditingControllerDepositDesc =
      TextEditingController();
  final RepositoryDeposit _repositoryDeposit = getIt.get<RepositoryDeposit>();
  final TransitionPage _transitionController = getIt.get<TransitionPage>();
  static String? valueSelectedButton;

  void changeSelectedButton({required String value}) {
    valueSelectedButton = value;
    update();
  }

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
        modelTransaction: TransactionModel(
            isDeposit: true,
            title: textEditingControllerDepositTitle.text,
            context: context,
            description: textEditingControllerDepositDesc.text,
            textSelectRent: valueSelectedButton ?? generalAccount,
            quantityMoney: double.parse(formatValueMoney(
                textValue: textEditingControllerDepositMoney.text))),
      );
      if (result) {
        if (HomeController.moneyValue != null) {
          valueAvailable = double.parse(HomeController.moneyValue!);
        } else {
          valueAvailable = 0;
        }
        newValue = double.parse(formatValueMoney(
            textValue: textEditingControllerDepositMoney.text));
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

  @override
  void dispose() {
    super.dispose();
    textEditingControllerDepositMoney.dispose();
    textEditingControllerDepositTitle.dispose();
    textEditingControllerDepositDesc.dispose();
  }
}
