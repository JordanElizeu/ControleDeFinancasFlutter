import 'package:app_financeiro/controller/transition_controller.dart';
import 'package:app_financeiro/controller/withdraw_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WithdrawMoney extends StatelessWidget {
  const WithdrawMoney({Key? key}) : super(key: key);

  final String _appBarTitle = 'Sacar dinheiro';
  final String _labelFieldMoney = 'Valor a sacar';

  @override
  Widget build(BuildContext context) {
    WithdrawMoneyController withdrawMoneyController = WithdrawMoneyController();
    return WillPopScope(
      onWillPop: () => TransitionController()
          .finishAndPageTransition(route: Routes.HOME, context: context),
      child: Scaffold(
        appBar: appBar(title: _appBarTitle),
        body: FormsToWithdrawAndDeposit(
          globalKeyTitle: withdrawMoneyController.formKeyFieldWithdrawTitle,
          globalKeyMoney: withdrawMoneyController.formKeyFieldWithdrawMoney,
          globalKeyDesc: withdrawMoneyController.formKeyFieldWithdrawDesc,
          textEditingControllerDesc:
              WithdrawMoneyController.textEditingControllerWithdrawDesc,
          textEditingControllerMoney:
              WithdrawMoneyController.textEditingControllerWithdrawMoney,
          textEditingControllerTitle:
              WithdrawMoneyController.textEditingControllerWithdrawTitle,
          functionValidateMoney: (String text) {
            return withdrawMoneyController.validateFieldFormTextMoney();
          },
          functionValidateDesc: (String text) {
            return withdrawMoneyController.validateFieldFormTextDesc();
          },
          functionValidateTitle: (String text) {
            return withdrawMoneyController.validateFieldFormTextTitle();
          },
          labelFieldMoney: _labelFieldMoney,
          functionButtonConfirm: () async {
            return await withdrawMoneyController.confirmMoneyWithdraw(
                context: context);
          },
        ),
      ),
    );
  }
}
