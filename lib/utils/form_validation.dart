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
