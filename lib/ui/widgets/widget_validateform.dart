import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';

class ValidateForm extends StatelessWidget {
  const ValidateForm(
      {Key? key,
      required this.label,
      required this.icon,
      required this.globalKey,
      this.controller,
      required this.function,
      this.fontSize,
      this.moneyInputFormatter,
      this.textAlign,
      this.textInputType})
      : super(key: key);

  final String label;
  final IconData icon;
  final GlobalKey<FormState> globalKey;
  final TextEditingController? controller;
  final Function(String text) function;
  final double? fontSize;
  final MoneyInputFormatter? moneyInputFormatter;
  final TextAlign? textAlign;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
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
}

void _showErrorFieldText(GlobalKey<FormState> globalKey) {
  final FormState? formRegisterValidated = globalKey.currentState;
  formRegisterValidated!.validate();
}
