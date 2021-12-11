import 'package:app_financeiro/controller/deposit_controller.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepositMoney extends StatelessWidget {
  const DepositMoney({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final DepositMoneyController _depositMoneyController =
        DepositMoneyController();
    return Scaffold(
      appBar: appBar(title: 'Depositar valor em conta'),
      body: FormToWithdrawAndDeposit(
              globalKeyTitle: DepositMoneyController.formKeyFieldTitle,
              globalKeyMoney: DepositMoneyController.formKeyFieldMoney,
              globalKeyDesc: DepositMoneyController.formKeyFieldDesc,
              textEditingControllerDesc:
                  DepositMoneyController.textEditingControllerDesc,
              textEditingControllerMoney:
                  DepositMoneyController.textEditingControllerMoney,
              textEditingControllerTitle:
                  DepositMoneyController.textEditingControllerTitle,
              functionValidateMoney: (String text) {
                return _depositMoneyController.validateFieldFormTextMoney(text);
              },
              functionValidateDesc: (String text) {
                return _depositMoneyController.validateFieldFormTextDesc(text);
              },
              functionValidateTitle: (String text) {
                return _depositMoneyController.validateFieldFormTextTitle(text);
              },
              labelFieldMoney: 'Valor a depositar',
              functionButtonConfirm: () {})
          .formsToWithdrawAndDeposit(),
    );
  }
}
