import 'package:app_financeiro/controller/withdraw_controller.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_forms.dart';
import 'package:app_financeiro/utils/transition_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/transaction_controller.dart';
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
  final TransactionController _transactionController =
      getIt.get<TransactionController>();
  final WithdrawMoneyController _withdrawMoneyController =
      Get.put(getIt.get<WithdrawMoneyController>());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _transitionPage.finishAndPageTransition(
          route: Routes.HOME, context: context),
      child: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: appBar(title: _appBarTitle),
          body: FutureBuilder<List<String>>(
            future: _transactionController.getTodoRent(),
            builder: (context, snapshot) {
              return GetBuilder<WithdrawMoneyController>(
                builder: ((controller) => FormsToWithdrawAndDeposit(
                      globalKeyTitle: formKeyFieldWithdrawTitle,
                      globalKeyMoney: formKeyFieldWithdrawMoney,
                      globalKeyDesc: formKeyFieldWithdrawDesc,
                      textEditingControllerDesc: _withdrawMoneyController
                          .textEditingControllerWithdrawDesc,
                      textEditingControllerMoney: _withdrawMoneyController
                          .textEditingControllerWithdrawMoney,
                      textEditingControllerTitle: _withdrawMoneyController
                          .textEditingControllerWithdrawTitle,
                      functionValidateMoney: (String text) {
                        return _withdrawMoneyController
                            .validateFieldFormTextMoney();
                      },
                      functionValidateDesc: (String text) {
                        return validateFieldFormTextDesc(text);
                      },
                      functionValidateTitle: (String text) {
                        return _withdrawMoneyController
                            .validateFieldFormTextTitle();
                      },
                      labelFieldMoney: _labelFieldMoney,
                      functionButtonConfirm: () async {
                        return await _withdrawMoneyController
                            .confirmMoneyWithdraw(
                          context: context,
                          formKeyTitle: formKeyFieldWithdrawTitle,
                          formKeyMoney: formKeyFieldWithdrawMoney,
                          formKeyDesc: formKeyFieldWithdrawDesc,
                        );
                      },
                      listRent: TransactionController.listRent,
                      constraints: constraints,
                      selectedButton:
                      WithdrawMoneyController.valueSelectedButton,
                      functionSelectedButton: (value) {
                        _withdrawMoneyController.changeSelectedButton(
                            value: value);
                      },
                    )),
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
    _withdrawMoneyController.textEditingControllerWithdrawDesc.text = '';
    _withdrawMoneyController.textEditingControllerWithdrawMoney.text = '';
    _withdrawMoneyController.textEditingControllerWithdrawTitle.text = '';
    WithdrawMoneyController.valueSelectedButton = null;
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
