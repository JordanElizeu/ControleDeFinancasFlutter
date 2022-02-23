import 'package:app_financeiro/controller/deposit_controller.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_forms.dart';
import 'package:flutter/material.dart';
import '../../utils/form_validation.dart';
import '../../utils/transition_page.dart';

class DepositMoney extends StatefulWidget {
  const DepositMoney({Key? key}) : super(key: key);

  @override
  State<DepositMoney> createState() => _DepositMoneyState();
}

class _DepositMoneyState extends State<DepositMoney> {
  final String _appBarTitle = 'Depositar dinheiro';
  final String _labelFieldMoney = 'Valor a depositar';
  final GlobalKey<FormState> formKeyDepositTitle = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyDepositDesc = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyDepositMoney = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final DepositMoneyController depositMoneyController =
        getIt.get<DepositMoneyController>();
    final TransitionPage transitionController = getIt.get<TransitionPage>();
    return WillPopScope(
      onWillPop: () => transitionController.finishAndPageTransition(
          route: Routes.HOME, context: context),
      child: Scaffold(
        appBar: appBar(title: _appBarTitle),
        body: FormsToWithdrawAndDeposit(
          globalKeyTitle: formKeyDepositTitle,
          globalKeyMoney: formKeyDepositMoney,
          globalKeyDesc: formKeyDepositDesc,
          textEditingControllerDesc:
              depositMoneyController.textEditingControllerDepositDesc,
          textEditingControllerMoney:
              depositMoneyController.textEditingControllerDepositMoney,
          textEditingControllerTitle:
              depositMoneyController.textEditingControllerDepositTitle,
          functionValidateMoney: (String text) {
            return depositMoneyController.validateFieldFormTextMoney(text);
          },
          functionValidateDesc: (String text) {
            return validateFieldFormTextDesc(text);
          },
          functionValidateTitle: (String text) {
            return validateFieldFormTextTitle(text: text);
          },
          labelFieldMoney: _labelFieldMoney,
          functionButtonConfirm: () async {
            return await depositMoneyController.confirmDeposit(
                context: context,
                formKeyDesc: formKeyDepositDesc,
                formKeyMoney: formKeyDepositMoney,
                formKeyTitle: formKeyDepositTitle);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (formKeyDepositDesc.currentState != null) {
      formKeyDepositDesc.currentState!.dispose();
    }
    if (formKeyDepositMoney.currentState != null) {
      formKeyDepositMoney.currentState!.dispose();
    }
    if (formKeyDepositTitle.currentState != null) {
      formKeyDepositTitle.currentState!.dispose();
    }
  }
}
