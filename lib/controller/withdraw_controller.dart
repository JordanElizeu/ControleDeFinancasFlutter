import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/repository/firebase/repository_withdraw.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'transition_controller.dart';
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
  final TransitionController _transitionController =
      getIt.get<TransitionController>();

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
        modelTransaction: ModelTransaction(
            textEditingControllerWithdrawTitle.text,
            textEditingControllerWithdrawDesc.text,
            context,
            moneyWithdraw,
            isDeposit: false),
      );
      if (success) {
        double valueAvailable = double.parse(HomeController.moneyValue);
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

  String? validateFieldFormTextDesc() {
    if (textEditingControllerWithdrawDesc.text.isEmpty) {
      return 'Preencha uma descrição';
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
