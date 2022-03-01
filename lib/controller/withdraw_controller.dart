import 'package:app_financeiro/data/model/transaction_model/transaction_model.dart';
import 'package:app_financeiro/data/repository/firebase/repository_withdraw.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/string_i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../utils/transition_page.dart';
import 'home_controller.dart';

class WithdrawMoneyController extends GetxController {
  final TextEditingController textEditingControllerWithdrawMoney =
      TextEditingController();
  final TextEditingController textEditingControllerWithdrawTitle =
      TextEditingController();
  final TextEditingController textEditingControllerWithdrawDesc =
      TextEditingController();
  final RepositoryWithdraw _repositoryWithdraw =
      getIt.get<RepositoryWithdraw>();
  final TransitionPage _transitionController = getIt.get<TransitionPage>();
  static String? valueSelectedButton;

  void changeSelectedButton({required String value}) {
    valueSelectedButton = value;
    update();
  }

  Future<void> confirmMoneyWithdraw({
    required BuildContext context,
    required GlobalKey<FormState> formKeyTitle,
    required GlobalKey<FormState> formKeyDesc,
    required GlobalKey<FormState> formKeyMoney,
  }) async {
    final FormState? formValidateTitle = formKeyTitle.currentState;
    final FormState? formValidateDesc = formKeyDesc.currentState;
    final FormState? formValidateMoney = formKeyMoney.currentState;

    if (formValidateTitle!.validate() &&
        formValidateDesc!.validate() &&
        formValidateMoney!.validate()) {
      double moneyWithdraw = double.parse(_formatMoneyValueInField());
      bool success = await _repositoryWithdraw.repositoryMoneyWithdraw(
        modelTransaction: TransactionModel(
            isDeposit: false,
            textSelectRent: valueSelectedButton ?? generalAccount,
            quantityMoney: moneyWithdraw,
            context: context,
            description: textEditingControllerWithdrawDesc.text,
            title: textEditingControllerWithdrawTitle.text),
      );
      if (success) {
        double valueAvailable;
        if (HomeController.moneyValue != null) {
          valueAvailable = double.parse(HomeController.moneyValue!);
        } else {
          valueAvailable = 0;
        }
        double newValue = double.parse(_formatMoneyValueInField());
        HomeController.moneyValue = (valueAvailable - newValue).toString();
        clearAllFields();
        _transitionController.finishAndPageTransition(
            route: Routes.HOME, context: context);
      }
    }
  }

  String? validateFieldFormTextMoney() {
    if (!_validateValueMoney()) {
      return 'Preencha um valor correto';
    }
    return null;
  }

  void clearAllFields() {
    textEditingControllerWithdrawTitle.text = '';
    textEditingControllerWithdrawDesc.text = '';
    textEditingControllerWithdrawMoney.text = '';
    update();
  }

  String? validateFieldFormTextTitle() {
    if (textEditingControllerWithdrawTitle.text.isEmpty) {
      return 'Preencha um título';
    }
    return null;
  }

  String _formatMoneyValueInField() {
    String formatToString = textEditingControllerWithdrawMoney.text
        .replaceAll(' ', '')
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
    return formatToString;
  }

  bool _validateValueMoney() {
    final double formatToDouble = double.parse(_formatMoneyValueInField());
    if (formatToDouble <= 0.0) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    textEditingControllerWithdrawMoney.dispose();
    textEditingControllerWithdrawTitle.dispose();
    textEditingControllerWithdrawDesc.dispose();
  }
}
