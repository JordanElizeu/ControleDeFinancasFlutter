import 'package:app_financeiro/data/repository/firebase/repository_deposit.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'controller.dart';

class DepositMoneyController extends GetxController {
  final TextEditingController textEditingControllerDepositMoney =
      TextEditingController();
  final TextEditingController textEditingControllerDepositTitle =
      TextEditingController();
  final TextEditingController textEditingControllerDepositDesc =
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
      await RepositoryDeposit().repositoryAddDeposit(
          quantityMoney: double.parse(_formatValueMoney()),
          title: textEditingControllerDepositTitle.text,
          context: context,
          description: textEditingControllerDepositDesc.text);
      Controller()
          .finishAndPageTransition(route: Routes.HOME, context: context);
    }
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
