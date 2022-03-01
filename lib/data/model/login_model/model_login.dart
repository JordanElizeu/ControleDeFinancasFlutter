import 'package:flutter/cupertino.dart';

class LoginModel {
  final String _password;
  final String _email;
  final BuildContext _context;

  LoginModel({password, email, context})
      : _password = password,
        _email = email,
        _context = context;

  BuildContext get context => _context;

  String get email => _email;

  String get password => _password;
}
