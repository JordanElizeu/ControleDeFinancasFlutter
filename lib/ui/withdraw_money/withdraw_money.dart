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
    WithdrawMoneyController withdrawMoneyController = WithdrawMoneyController();
    return WillPopScope(
      onWillPop: () => Controller()
          .finishAndPageTransition(route: Routes.HOME, context: context),
      child: Scaffold(
        appBar: appBar(title: 'Sacar dinheiro'),
        body: FormsToWithdrawAndDeposit(
            globalKeyTitle: withdrawMoneyController.formKeyFieldWithdrawTitle,
            globalKeyMoney: withdrawMoneyController.formKeyFieldWithdrawMoney,
            globalKeyDesc: withdrawMoneyController.formKeyFieldWithdrawDesc,
            textEditingControllerDesc:
                withdrawMoneyController.textEditingControllerWithdrawDesc,
            textEditingControllerMoney:
                withdrawMoneyController.textEditingControllerWithdrawMoney,
            textEditingControllerTitle:
                withdrawMoneyController.textEditingControllerWithdrawTitle,
            functionValidateMoney: (String text) {
              return withdrawMoneyController.validateFieldFormTextMoney();
            },
            functionValidateDesc: (String text) {
              return withdrawMoneyController.validateFieldFormTextDesc();
            },
            functionValidateTitle: (String text) {
              return withdrawMoneyController.validateFieldFormTextTitle();
            },
            labelFieldMoney: 'Valor a sacar',
            functionButtonConfirm: () async {
              return withdrawMoneyController.confirmMoneyWithdraw(
                  context: context);
            }),
      ),
    );
  }
}
