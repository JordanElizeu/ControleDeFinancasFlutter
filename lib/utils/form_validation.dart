String? validateName(String? text) {
  if (text!.length > 20) {
    return 'Nome muito grande';
  }
  if (text.isEmpty) {
    return 'Digite seu nome';
  }
  return null;
}

String? validatePassword(String text) {
  if (text.length < 6) {
    return 'Senha inválida';
  }
  if (text.isEmpty) {
    return 'Digite sua senha';
  }
  return null;
}

String? validateEmail(String text) {
  if (!text.contains('@gmail.com')) {
    return 'Email inválido';
  }
  if (text.isEmpty) {
    return 'Digite seu email';
  }
  return null;
}

String? validateFieldFormTextTitle({required String text}) {
  if (text.isEmpty) {
    return 'Preencha um título';
  }
  return null;
}

String? validateFieldFormTextAnnotation({required String text}) {
  if (text.isEmpty) {
    return 'Preencha uma anotação';
  }
  return null;
}

String? validateFieldFormTextDesc(text) {
  if (text.isEmpty) {
    return 'Preencha uma descrição';
  }
  return null;
}

String formatValueMoney({required textValue}) {
  return textValue
      .replaceAll(' ', '')
      .replaceAll('R\$', '')
      .replaceAll('.', '')
      .replaceAll(',', '.');
}

bool _validateValueMoney(text) {
  String formatToString = formatValueMoney(textValue: text);
  final double formatToDouble = double.parse(formatToString);
  if (formatToDouble <= 0.0) {
    return false;
  }
  return true;
}

String? validateFieldFormTextMoney(text) {
  if (!_validateValueMoney(text)) {
    return 'Preencha um valor correto';
  }
  return null;
}
