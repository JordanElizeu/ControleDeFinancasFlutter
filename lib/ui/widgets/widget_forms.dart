import 'package:app_financeiro/ui/widgets/widget_validateform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';

class FormsToWithdrawAndDeposit extends StatelessWidget {
  const FormsToWithdrawAndDeposit(
      {Key? key,
      required this.globalKeyTitle,
      required this.globalKeyDesc,
      required this.globalKeyMoney,
      required this.textEditingControllerTitle,
      required this.textEditingControllerDesc,
      required this.textEditingControllerMoney,
      required this.functionValidateTitle,
      required this.functionValidateDesc,
      required this.functionValidateMoney,
      required this.functionButtonConfirm,
      required this.labelFieldMoney})
      : super(key: key);

  final GlobalKey<FormState> globalKeyTitle;
  final GlobalKey<FormState> globalKeyDesc;
  final GlobalKey<FormState> globalKeyMoney;
  final TextEditingController textEditingControllerTitle;
  final TextEditingController textEditingControllerDesc;
  final TextEditingController textEditingControllerMoney;
  final Function(String text) functionValidateTitle;
  final Function(String text) functionValidateDesc;
  final Function(String text) functionValidateMoney;
  final Future<void> Function() functionButtonConfirm;
  final String labelFieldMoney;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Form(
                  key: globalKeyTitle,
                  child: ValidateForm(
                      label: 'Título',
                      icon: Icons.wysiwyg,
                      controller: textEditingControllerTitle,
                      globalKey: globalKeyTitle,
                      function: functionValidateTitle),
                ),
                Form(
                    key: globalKeyDesc,
                    child: ValidateForm(
                        icon: Icons.chat,
                        label: 'Descrição',
                        controller: textEditingControllerDesc,
                        globalKey: globalKeyDesc,
                        function: functionValidateDesc)),
                Form(
                  key: globalKeyMoney,
                  child: ValidateForm(
                      label: labelFieldMoney,
                      textAlign: TextAlign.center,
                      textInputType: TextInputType.number,
                      moneyInputFormatter: MoneyInputFormatter(
                        leadingSymbol: 'R\$',
                        useSymbolPadding: true,
                        thousandSeparator: ThousandSeparator.Period,
                      ),
                      icon: Icons.monetization_on,
                      fontSize: 20.0,
                      controller: textEditingControllerMoney,
                      globalKey: globalKeyMoney,
                      function: functionValidateMoney),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: functionButtonConfirm,
                        child: const Text('Confirmar'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
