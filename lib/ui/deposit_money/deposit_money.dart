import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/controller/deposit_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepositMoney extends StatelessWidget {
  const DepositMoney({Key? key}) : super(key: key);

  final String _appBarTitle = 'Depositar dinheiro';
  final String _labelFieldMoney = 'Valor a depositar';

  @override
  Widget build(BuildContext context) {
    final DepositMoneyController depositMoneyController =
        DepositMoneyController();
    return WillPopScope(
      onWillPop: () => Controller()
          .finishAndPageTransition(route: Routes.HOME, context: context),
      child: Scaffold(
        appBar: appBar(title: _appBarTitle),
        body: FormsToWithdrawAndDeposit(
            globalKeyTitle: depositMoneyController.formKeyFieldDepositTitle,
            globalKeyMoney: depositMoneyController.formKeyFieldDepositMoney,
            globalKeyDesc: depositMoneyController.formKeyFieldDepositDesc,
            textEditingControllerDesc:
                depositMoneyController.textEditingControllerDepositDesc,
            textEditingControllerMoney:
                depositMoneyController.textEditingControllerDepositMoney,
            textEditingControllerTitle:
                depositMoneyController.textEditingControllerDepositTitle,
            functionValidateMoney: (String text) {
              return depositMoneyController.validateFieldFormTextMoney();
            },
            functionValidateDesc: (String text) {
              return depositMoneyController.validateFieldFormTextDesc();
            },
            functionValidateTitle: (String text) {
              return depositMoneyController.validateFieldFormTextTitle();
            },
            labelFieldMoney: _labelFieldMoney,
            functionButtonConfirm: () {
              return depositMoneyController.confirmDeposit(context: context);
            }),
      ),
    );
  }
}
