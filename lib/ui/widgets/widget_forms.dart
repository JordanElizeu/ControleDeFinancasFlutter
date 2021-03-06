import 'package:app_financeiro/ui/widgets/widget_dropdown_button.dart';
import 'package:app_financeiro/ui/widgets/widget_validateform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';

class FormsToWithdrawAndDeposit extends StatelessWidget {
  const FormsToWithdrawAndDeposit({
    Key? key,
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
    required this.labelFieldMoney,
    required this.constraints,
    required this.listRent,
    required this.selectedButton,
    required this.functionSelectedButton,
  }) : super(key: key);

  final GlobalKey<FormState> globalKeyTitle;
  final GlobalKey<FormState> globalKeyDesc;
  final GlobalKey<FormState> globalKeyMoney;
  final BoxConstraints constraints;
  final TextEditingController textEditingControllerTitle;
  final TextEditingController textEditingControllerDesc;
  final TextEditingController textEditingControllerMoney;
  final List<String> listRent;
  final Function(String text) functionValidateTitle;
  final Function(String text) functionValidateDesc;
  final Function(String text) functionValidateMoney;
  final Future<void> Function() functionButtonConfirm;
  final String labelFieldMoney;
  final String? selectedButton;
  final Function(dynamic) functionSelectedButton;

  final String _textButtonConfirm = 'Confirmar';
  final String _textLabelDescription = 'Descrição';
  final String _textLabelTitle = 'Título';

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
                      label: _textLabelTitle,
                      icon: Icons.wysiwyg,
                      controller: textEditingControllerTitle,
                      globalKey: globalKeyTitle,
                      function: functionValidateTitle),
                ),
                Form(
                  key: globalKeyDesc,
                  child: ValidateForm(
                      icon: Icons.chat,
                      label: _textLabelDescription,
                      controller: textEditingControllerDesc,
                      globalKey: globalKeyDesc,
                      function: functionValidateDesc),
                ),
                WidgetMenuButton(
                  constraints: constraints,
                  items: listRent,
                  selectedValueMenuButton: selectedButton,
                  functionSelectedMenuButton: functionSelectedButton,
                ),
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
                      fontSize: 18.0,
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
                        child: Text(_textButtonConfirm),
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
