import 'package:app_financeiro/controller/deposit_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class Deposit extends StatelessWidget {
  const Deposit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Depositar valor em conta'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Form(
                    key: IncrementMoneyController.formKeyFieldTitle,
                    child: _textField(
                        label: 'Título',
                        icon: Icons.wysiwyg,
                        moneyInputFormatter: null,
                        controller:
                            IncrementMoneyController.textEditingControllerTitle,
                        globalKey: IncrementMoneyController.formKeyFieldTitle,
                        function: (String text) {
                          return IncrementMoneyController().validateFieldFormTextTitle(text);
                        }),
                  ),
                  Form(
                    key: IncrementMoneyController.formKeyFieldDesc,
                    child: _textField(
                        icon: Icons.chat,
                        label: 'Descrição',
                        moneyInputFormatter: null,
                        controller:
                            IncrementMoneyController.textEditingControllerDesc,
                        globalKey: IncrementMoneyController.formKeyFieldDesc,
                        function: (String text) {
                          return IncrementMoneyController().validateFieldFormTextDesc(text);
                        }),
                  ),
                  Form(
                    key: IncrementMoneyController.formKeyFieldMoney,
                    child: _textField(
                        label: 'Valor a depositar',
                        textAlign: TextAlign.center,
                        textInputType: TextInputType.number,
                        moneyInputFormatter: MoneyInputFormatter(
                          leadingSymbol: 'R\$',
                          useSymbolPadding: true,
                          thousandSeparator: ThousandSeparator.Period,
                        ),
                        icon: Icons.monetization_on,
                        fontSize: 20.0,
                        controller:
                            IncrementMoneyController.textEditingControllerMoney,
                        globalKey: IncrementMoneyController.formKeyFieldMoney,
                        function: (String text) {
                          return IncrementMoneyController()
                              .validateFieldFormTextMoney(text);
                        }),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          child: Text('Salvar'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _textField(
    {required String label,
    required IconData icon,
    required GlobalKey<FormState> globalKey,
    double? fontSize,
    required MoneyInputFormatter? moneyInputFormatter,
    required TextEditingController controller,
    required Function(String text) function,
    TextAlign? textAlign,
    TextInputType? textInputType}) {
  return TextFormField(
    style: TextStyle(fontSize: fontSize ?? 16.0),
    textAlign: textAlign ?? TextAlign.left,
    controller: controller,
    keyboardType: textInputType,
    onChanged: (value) {
      IncrementMoneyController().showErrorFieldText(globalKey);
    },
    decoration: InputDecoration(
      label: Text(label),
      icon: Icon(icon),
    ),
    inputFormatters: [
      moneyInputFormatter ?? FilteringTextInputFormatter.singleLineFormatter
    ],
    validator: (text) {
      print(text);
      return function(text!);
    },
  );
}
