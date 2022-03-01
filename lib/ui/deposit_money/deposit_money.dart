import 'package:app_financeiro/controller/deposit_controller.dart';
import 'package:app_financeiro/controller/transaction_controller.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_forms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final GlobalKey<FormState> _formKeyDepositTitle = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyDepositDesc = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyDepositMoney = GlobalKey<FormState>();
  final DepositMoneyController _depositMoneyController =
      Get.put(getIt.get<DepositMoneyController>());
  final TransitionPage _transitionController = getIt.get<TransitionPage>();
  final TransactionController _transactionController =
      getIt.get<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _transitionController.finishAndPageTransition(
          route: Routes.HOME, context: context),
      child: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: appBar(title: _appBarTitle),
          body: FutureBuilder<List<String>>(
            future: _transactionController.getTodoRent(),
            builder: (context, snapshot) {
              return GetBuilder<DepositMoneyController>(
                builder: (depositMoneyController) {
                  return FormsToWithdrawAndDeposit(
                    globalKeyTitle: _formKeyDepositTitle,
                    globalKeyMoney: _formKeyDepositMoney,
                    globalKeyDesc: _formKeyDepositDesc,
                    textEditingControllerDesc:
                        depositMoneyController.textEditingControllerDepositDesc,
                    textEditingControllerMoney: depositMoneyController
                        .textEditingControllerDepositMoney,
                    textEditingControllerTitle: depositMoneyController
                        .textEditingControllerDepositTitle,
                    functionValidateMoney: (String text) {
                      return validateFieldFormTextMoney(text);
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
                          formKeyDesc: _formKeyDepositDesc,
                          formKeyMoney: _formKeyDepositMoney,
                          formKeyTitle: _formKeyDepositTitle);
                    },
                    constraints: constraints,
                    listRent: TransactionController.listRent,
                    selectedButton: DepositMoneyController.valueSelectedButton,
                    functionSelectedButton: (value) {
                      depositMoneyController.changeSelectedButton(value: value);
                    },
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    DepositMoneyController.valueSelectedButton = null;
    _depositMoneyController.textEditingControllerDepositDesc.text = '';
    _depositMoneyController.textEditingControllerDepositTitle.text = '';
    _depositMoneyController.textEditingControllerDepositMoney.text = '';
    if (_formKeyDepositDesc.currentState != null) {
      _formKeyDepositDesc.currentState!.dispose();
    }
    if (_formKeyDepositMoney.currentState != null) {
      _formKeyDepositMoney.currentState!.dispose();
    }
    if (_formKeyDepositTitle.currentState != null) {
      _formKeyDepositTitle.currentState!.dispose();
    }
  }
}
