import 'package:app_financeiro/data/model/model_login/model_login.dart';
import 'package:flutter/cupertino.dart';

class ModelCreateUser extends ModelLogin{

  final String _name;

  ModelCreateUser(String password, String email, BuildContext context, this._name) : super(password, email, context);

  String get name => _name;
}