import 'package:app_financeiro/controller/deposit_controller.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_validateform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class Deposit extends StatelessWidget {
  const Deposit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Depositar valor em conta'),
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
                    child: textField(
                        label: 'Título',
                        icon: Icons.wysiwyg,
                        controller:
                            IncrementMoneyController.textEditingControllerTitle,
                        globalKey: IncrementMoneyController.formKeyFieldTitle,
                        function: (String text) {
                          return IncrementMoneyController().validateFieldFormTextTitle(text);
                        }),
                  ),
                  Form(
                    key: IncrementMoneyController.formKeyFieldDesc,
                    child: textField(
                        icon: Icons.chat,
                        label: 'Descrição',
                        controller:
                            IncrementMoneyController.textEditingControllerDesc,
                        globalKey: IncrementMoneyController.formKeyFieldDesc,
                        function: (String text) {
                          return IncrementMoneyController().validateFieldFormTextDesc(text);
                        }),
                  ),
                  Form(
                    key: IncrementMoneyController.formKeyFieldMoney,
                    child: textField(
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
