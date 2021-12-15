import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';

class WidgetTextField {
  Widget textField(
      {required String label,
      required IconData icon,
      required GlobalKey<FormState> globalKey,
      required TextEditingController? controller,
      required Function(String text) function,
      double? fontSize,
      MoneyInputFormatter? moneyInputFormatter,
      TextAlign? textAlign,
      TextInputType? textInputType}) {
    return TextFormField(
      style: TextStyle(fontSize: fontSize ?? 16.0),
      textAlign: textAlign ?? TextAlign.left,
      controller: controller,
      keyboardType: textInputType,
      onChanged: (value) {
        _showErrorFieldText(globalKey);
      },
      decoration: InputDecoration(
        label: Text(label),
        icon: Icon(icon),
      ),
      inputFormatters: [
        moneyInputFormatter ?? FilteringTextInputFormatter.singleLineFormatter
      ],
      validator: (text) {
        return function(text!);
      },
    );
  }

  void _showErrorFieldText(GlobalKey<FormState> globalKey) {
    final FormState? formRegisterValidated = globalKey.currentState;
    formRegisterValidated!.validate();
  }
}
