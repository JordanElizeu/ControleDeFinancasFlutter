import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class IncrementMoney extends StatelessWidget {
  const IncrementMoney({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.purple,
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,bottom: 20.0),
                  child: Text(
                    'Depositar valor em conta',
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _textField(
                        label: 'Título',
                        icon: Icons.wysiwyg,
                        moneyInputFormatter: null,
                        fontSize: 16.0),
                    _textField(
                        icon: Icons.chat,
                        label: 'Descrição',
                        moneyInputFormatter: null,
                        fontSize: 16.0),
                    _textField(
                        label: 'Valor',
                        textAlign: TextAlign.center,
                        textInputType: TextInputType.number,
                        moneyInputFormatter: MoneyInputFormatter(
                          leadingSymbol: 'R\$',
                          useSymbolPadding: true,
                          thousandSeparator: ThousandSeparator.Period,
                        ),
                        icon: Icons.monetization_on,
                        fontSize: 22.0),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Salvar'),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _textField(
    {required String label,
    required IconData icon,
    required double fontSize,
    required MoneyInputFormatter? moneyInputFormatter,
    TextAlign? textAlign,
    TextInputType? textInputType}) {
  return TextFormField(
    style: TextStyle(fontSize: fontSize),
    textAlign: textAlign ?? TextAlign.left,
    keyboardType: textInputType,
    decoration: InputDecoration(
      label: Text(label),
      icon: Icon(icon),
    ),
    inputFormatters: [
      moneyInputFormatter ?? FilteringTextInputFormatter.singleLineFormatter
    ],
  );
}
