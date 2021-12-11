import 'package:app_financeiro/controller/withdraw_controller.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WithdrawMoney extends StatelessWidget {
  const WithdrawMoney({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WithdrawMoneyController _withdrawMoneyController =
        WithdrawMoneyController();
    return Scaffold(
      appBar: appBar(title: 'Sacar dinheiro'),
      body: FormToWithdrawAndDeposit(
              globalKeyTitle: WithdrawMoneyController.formKeyFieldTitle,
              globalKeyMoney: WithdrawMoneyController.formKeyFieldMoney,
              globalKeyDesc: WithdrawMoneyController.formKeyFieldDesc,
              textEditingControllerDesc:
                  WithdrawMoneyController.textEditingControllerDesc,
              textEditingControllerMoney:
                  WithdrawMoneyController.textEditingControllerMoney,
              textEditingControllerTitle:
                  WithdrawMoneyController.textEditingControllerTitle,
              functionValidateMoney: (String text) {
                return _withdrawMoneyController
                    .validateFieldFormTextMoney(text);
              },
              functionValidateDesc: (String text) {
                return _withdrawMoneyController.validateFieldFormTextDesc(text);
              },
              functionValidateTitle: (String text) {
                return _withdrawMoneyController
                    .validateFieldFormTextTitle(text);
              },
              labelFieldMoney: 'Valor a sacar',
              functionButtonConfirm: (){})
          .formsToWithdrawAndDeposit(),
    );
  }
}
