import 'package:app_financeiro/controller/annotation_controller.dart';
import 'package:app_financeiro/ui/widgets/widget_validateform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAnnotations extends StatelessWidget {
  final String buttonText = 'Confirmar';
  final Function()? function;

  CreateAnnotations(this.function);

  @override
  Widget build(BuildContext context) {
    AnnotationsController annotationsController =
        AnnotationsController(context: context);
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
                    annotationsController.validateFieldFormTextTitle();
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
                    annotationsController.validateFieldFormTextAnnotation();
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
            onPressed: function?? () {
              AnnotationsController(context: context).sendAnnotation();
              Navigator.pop(context);
            })
      ],
    );
  }
}

alertDialogCreateAnnotation({
  required BuildContext context,
  String? initialValueAnnotation,
  String? initialValueTitle,
  Function()? function,
}) async {
  AnnotationsController.textEditingControllerAnnotation.text = initialValueAnnotation??'';
  AnnotationsController.textEditingControllerTitle.text = initialValueTitle??'';
  await showDialog(
      context: context,
      builder: (contextDialog) {
        return CreateAnnotations(function);
      });
}
