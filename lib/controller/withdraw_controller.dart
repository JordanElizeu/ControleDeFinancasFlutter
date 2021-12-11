import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'initial_controller.dart';

class WithdrawMoneyController extends GetxController{
  static TextEditingController textEditingControllerMoney =
  TextEditingController();
  static TextEditingController textEditingControllerTitle =
  TextEditingController();
  static TextEditingController textEditingControllerDesc =
  TextEditingController();
  static GlobalKey<FormState> formKeyFieldTitle = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldDesc = GlobalKey<FormState>();
  static GlobalKey<FormState> formKeyFieldMoney = GlobalKey<FormState>();

  void incrementMoney({required double valor}) {
    InitialController().setValorTotal = valor;
  }

  void saveDeposit(){
    final FormState? formValidateTitle = formKeyFieldTitle.currentState;
    final FormState? formValidateDesc = formKeyFieldDesc.currentState;
    final FormState? formValidateMoney = formKeyFieldMoney.currentState;

    if (formValidateTitle!.validate() &&
        formValidateDesc!.validate() &&
        formValidateMoney!.validate()) {
      //method to save deposit_money
    }
  }

  String? validateFieldFormTextMoney(String text) {
    if (!_validateValueMoney(text)) {
      return 'Preencha um valor correto';
    }
    return null;
  }

  String? validateFieldFormTextTitle(String text) {
    if (text.isEmpty) {
      return 'Preencha um título';
    }
    return null;
  }

  String? validateFieldFormTextDesc(String text) {
    if (text.isEmpty) {
      return 'Preencha uma descrição';
    }
    return null;
  }

  bool _validateValueMoney(String text) {
    String formatToString = text
        .replaceAll(' ', '')
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
    final double formatToDouble = double.parse(formatToString);
    if (formatToDouble <= 0.0) {
      return false;
    }
    return true;
  }
}
