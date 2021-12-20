import 'package:app_financeiro/controller/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewLogout extends StatelessWidget {
  final String _textButtonConfirm = 'Confirmar';
  final String _textButtonCancel = 'Cancelar';
  final String _titleLogout = 'Sair da conta';
  final String textLogout =
      'Você está prestes a sair da sua conta, tem certeza ?';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_titleLogout),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.exit_to_app,
              size: 50,
              color: Colors.red,
            ),
          ),
          Text(
            textLogout,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_textButtonCancel),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_textButtonConfirm),
            ),
            onPressed: () {
              LoginController(context).logoutAccount();
            }),
      ],
    );
  }
}

alertDialogViewSuccess({required BuildContext context}) async {
  await showDialog(
    context: context,
    builder: (contextDialog) {
      return ViewLogout();
    },
  );
}
