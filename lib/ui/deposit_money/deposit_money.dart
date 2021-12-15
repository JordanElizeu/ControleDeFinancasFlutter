import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/controller/deposit_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepositMoney extends StatelessWidget {
  const DepositMoney({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final DepositMoneyController depositMoneyController =
        DepositMoneyController(context);
    return WillPopScope(
      onWillPop: () =>
          Controller(context).finishAndPageTransition(route: Routes.HOME),
      child: Scaffold(
        appBar: appBar(title: 'Depositar dinheiro'),
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
              return depositMoneyController.validateFieldFormTextMoney();
            },
            functionValidateDesc: (String text) {
              return depositMoneyController.validateFieldFormTextDesc();
            },
            functionValidateTitle: (String text) {
              return depositMoneyController.validateFieldFormTextTitle();
            },
            labelFieldMoney: 'Valor a depositar',
            functionButtonConfirm: () {
              return depositMoneyController.confirmDeposit();
            }).formsToWithdrawAndDeposit(),
      ),
    );
  }
}
