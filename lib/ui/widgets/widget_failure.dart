import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewFailure extends StatelessWidget {
  final String buttonText = 'Confirmar';
  final String titleError;
  final Function() functionButton;

  ViewFailure({required this.functionButton, required this.titleError});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Aconteceu um erro'),
      content: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off),
            Text(
              titleError,
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

class FailureDialog extends StatelessWidget {
  final Function() functionButton;
  final String titleError;
  FailureDialog({
    required this.functionButton,
    required this.titleError,
  });

  @override
  Widget build(BuildContext context) {
    return ViewFailure(
      functionButton: functionButton,
      titleError: titleError,
    );
  }
}

alertDialogViewFailure(
    {required BuildContext context,
    required Function() function,
    required String titleError}) async {
  await showDialog(
    context: context,
    builder: (contextDialog) {
      return FailureDialog(
        functionButton: function,
        titleError: titleError,
      );
    },
  );
}
