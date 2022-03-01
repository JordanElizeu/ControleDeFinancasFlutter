import 'package:app_financeiro/data/model/login_model/model_login.dart';
import 'package:flutter/cupertino.dart';

class CreateUserModel extends LoginModel {
  final String _name;

  CreateUserModel(
      String password, String email, BuildContext context, this._name)
      : super(email: email, context: context, password: password);

  String get name => _name;
}
