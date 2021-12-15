import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/controller/withdraw_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WithdrawMoney extends StatelessWidget {
  const WithdrawMoney({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WithdrawMoneyController _withdrawMoneyController =
        WithdrawMoneyController(context);
    return WillPopScope(
      onWillPop: () =>
          Controller(context).finishAndPageTransition(route: Routes.HOME) ??
          false,
      child: Scaffold(
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
              return _withdrawMoneyController.validateFieldFormTextMoney();
            },
            functionValidateDesc: (String text) {
              return _withdrawMoneyController.validateFieldFormTextDesc();
            },
            functionValidateTitle: (String text) {
              return _withdrawMoneyController.validateFieldFormTextTitle();
            },
            labelFieldMoney: 'Valor a sacar',
            functionButtonConfirm: () async {
              return await _withdrawMoneyController.confirmMoneyWithdraw();
            }).formsToWithdrawAndDeposit(),
      ),
    );
  }
}
