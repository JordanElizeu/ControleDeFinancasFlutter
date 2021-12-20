import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewSuccess extends StatelessWidget {
  final String _buttonText = 'Confirmar';
  final String _titleSuccess = 'Concluído com sucesso';
  final String textSuccess;
  final Function() functionButton;

  ViewSuccess({required this.functionButton, required this.textSuccess});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_titleSuccess),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.monetization_on,
              size: 100,
            ),
          ),
          Text(
            textSuccess,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_buttonText),
            ),
            onPressed: functionButton)
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final Function() functionButton;
  final String titleSuccess;
  SuccessDialog({
    required this.functionButton,
    required this.titleSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return ViewSuccess(
      functionButton: functionButton,
      textSuccess: titleSuccess,
    );
  }
}

alertDialogViewSuccess(
    {required BuildContext context,
    required Function() function,
    required String titleSuccess}) async {
  await showDialog(
    context: context,
    builder: (contextDialog) {
      return SuccessDialog(
        functionButton: function,
        titleSuccess: titleSuccess,
      );
    },
  );
}
