import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewSuccess extends StatelessWidget {
  final String buttonText = 'Confirmar';
  final String titleSuccess;
  final Function() functionButton;

  ViewSuccess({required this.functionButton, required this.titleSuccess});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Concluído com sucesso'),
      content: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.monetization_on),
            Text(
              titleSuccess,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(buttonText),
            ),
            onPressed: functionButton)
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final Function() functionButton;
  final String titleError;
  SuccessDialog({
    required this.functionButton,
    required this.titleError,
  });

  @override
  Widget build(BuildContext context) {
    return ViewSuccess(
      functionButton: functionButton,
      titleSuccess: titleError,
    );
  }
}

alertDialogViewSuccess(
    {required BuildContext context,
    required Function() function,
    required String titleError}) async {
  await showDialog(
    context: context,
    builder: (contextDialog) {
      return SuccessDialog(
        functionButton: function,
        titleError: titleError,
      );
    },
  );
}
