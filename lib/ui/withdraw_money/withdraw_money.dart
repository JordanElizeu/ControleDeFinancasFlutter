import 'package:app_financeiro/controller/withdraw_controller.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_forms.dart';
import 'package:app_financeiro/utils/transition_page.dart';
import 'package:flutter/material.dart';

import '../../utils/form_validation.dart';

class WithdrawMoney extends StatefulWidget {
  const WithdrawMoney({Key? key}) : super(key: key);

  @override
  State<WithdrawMoney> createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
  final String _appBarTitle = 'Sacar dinheiro';
  final String _labelFieldMoney = 'Valor a sacar';
  final GlobalKey<FormState> formKeyFieldWithdrawTitle = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyFieldWithdrawDesc = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyFieldWithdrawMoney = GlobalKey<FormState>();
  final TransitionPage _transitionPage = getIt.get<TransitionPage>();

  @override
  Widget build(BuildContext context) {
    WithdrawMoneyController withdrawMoneyController =
        getIt.get<WithdrawMoneyController>();
    return WillPopScope(
      onWillPop: () => _transitionPage.finishAndPageTransition(
          route: Routes.HOME, context: context),
      child: Scaffold(
        appBar: appBar(title: _appBarTitle),
        body: FormsToWithdrawAndDeposit(
          globalKeyTitle: formKeyFieldWithdrawTitle,
          globalKeyMoney: formKeyFieldWithdrawMoney,
          globalKeyDesc: formKeyFieldWithdrawDesc,
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
            return validateFieldFormTextDesc(text);
          },
          functionValidateTitle: (String text) {
            return withdrawMoneyController.validateFieldFormTextTitle();
          },
          labelFieldMoney: _labelFieldMoney,
          functionButtonConfirm: () async {
            return await withdrawMoneyController.confirmMoneyWithdraw(
              context: context,
              formKeyTitle: formKeyFieldWithdrawTitle,
              formKeyMoney: formKeyFieldWithdrawMoney,
              formKeyDesc: formKeyFieldWithdrawDesc,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (formKeyFieldWithdrawDesc.currentState != null) {
      formKeyFieldWithdrawDesc.currentState!.dispose();
    }
    if (formKeyFieldWithdrawMoney.currentState != null) {
      formKeyFieldWithdrawMoney.currentState!.dispose();
    }
    if (formKeyFieldWithdrawTitle.currentState != null) {
      formKeyFieldWithdrawTitle.currentState!.dispose();
    }
  }
}
