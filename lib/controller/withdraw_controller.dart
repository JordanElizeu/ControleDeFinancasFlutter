import 'package:app_financeiro/data/model/model_transaction/model_transaction.dart';
import 'package:app_financeiro/data/repository/firebase/repository_withdraw.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'initial_controller.dart';

class WithdrawMoneyController extends GetxController with DisposableWidget {
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
      double moneyWithdraw = double.parse(_formatMoneyValueInField());
      bool success = await RepositoryWithdraw().repositoryMoneyWithdraw(
          modelTransaction: ModelTransaction(
              textEditingControllerWithdrawTitle.text,
              textEditingControllerWithdrawDesc.text,
              context,
              moneyWithdraw,
              isDeposit: false));
      if (success) {
        double valueAvailable = double.parse(InitialController.moneyValue);
        double newValue = double.parse(_formatMoneyValueInField());
        InitialController.moneyValue = (valueAvailable - newValue).toString();
        Controller()
            .finishAndPageTransition(route: Routes.HOME, context: context);
      }
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
    cancelSubscriptions();
    super.dispose();
  }
}
