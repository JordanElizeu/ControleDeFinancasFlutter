import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewFailure extends StatelessWidget {
  final String buttonText = 'Confirmar';
  final String titleError;
  final String messageError;
  final Function()? functionButton;

  ViewFailure(
      {required this.functionButton,
      required this.titleError,
      required this.messageError});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleError),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            color: Colors.red,
            size: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              messageError,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(buttonText),
          ),
          onPressed: functionButton ??
              () {
                Navigator.pop(context);
              },
        )
      ],
    );
  }
}

class FailureDialog extends StatelessWidget {
  final Function()? functionButton;
  final String titleError;
  final String messageError;
  FailureDialog({
    required this.functionButton,
    required this.titleError,
    required this.messageError,
  });

  @override
  Widget build(BuildContext context) {
    return ViewFailure(
      functionButton: functionButton,
      titleError: titleError,
      messageError: messageError,
    );
  }
}

alertDialogViewFailure(
    {required BuildContext context,
    required String messageError,
    Function()? function,
    required String titleError}) async {
  await showDialog(
    context: context,
    builder: (contextDialog) {
      return FailureDialog(
        functionButton: function ?? null,
        titleError: titleError,
        messageError: messageError,
      );
    },
  );
}
