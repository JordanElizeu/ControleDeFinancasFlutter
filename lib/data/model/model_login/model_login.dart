import 'package:flutter/cupertino.dart';

class ModelLogin{

  final String _password;
  final String _email;
  final BuildContext _context;

  ModelLogin(this._password, this._email, this._context);

  BuildContext get context => _context;

  String get email => _email;

  String get password => _password;
}