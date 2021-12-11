import 'package:app_financeiro/controller/annotation_controller.dart';
import 'package:app_financeiro/ui/widgets/widget_validateform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAnnotations extends StatelessWidget {
  final String buttonText = 'Confirmar';
  final Function() functionButton;

  CreateAnnotations({
    required this.functionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Criar anotação'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
            child: Form(
              key: AnnotationsController.formKeyFieldTitle,
              child: WidgetTextField().textField(
                  label: 'Título',
                  icon: Icons.wysiwyg,
                  globalKey: AnnotationsController.formKeyFieldTitle,
                  controller: AnnotationsController.textEditingControllerTitle,
                  function: (String text) {
                    AnnotationsController().validateFieldFormTextTitle();
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
            child: Form(
              key: AnnotationsController.formKeyFieldAnnotation,
              child: WidgetTextField().textField(
                  label: 'Anotação',
                  icon: Icons.chat,
                  globalKey: AnnotationsController.formKeyFieldAnnotation,
                  controller:
                      AnnotationsController.textEditingControllerAnnotation,
                  function: (String text) {
                    AnnotationsController().validateFieldFormTextAnnotation();
                  }),
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
            onPressed: functionButton)
      ],
    );
  }
}

class AnnotationDialog extends StatelessWidget {
  final Function() functionButton;
  AnnotationDialog({required this.functionButton});

  @override
  Widget build(BuildContext context) {
    return CreateAnnotations(
      functionButton: functionButton,
    );
  }
}

alertDialogCreateAnnotation({
  required BuildContext context,
  required Function() function,
}) async {
  await showDialog(
      context: context,
      builder: (contextDialog) {
        return AnnotationDialog(
          functionButton: function,
        );
      });
}
