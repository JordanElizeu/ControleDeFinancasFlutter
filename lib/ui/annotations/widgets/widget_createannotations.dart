import 'package:app_financeiro/controller/annotation_controller.dart';
import 'package:app_financeiro/ui/widgets/widget_validateform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAnnotations extends StatelessWidget {
  final String buttonText = 'Confirmar';
  static BuildContext? context;
  final Function()? function;

  CreateAnnotations(this.function);

  @override
  Widget build(BuildContext context) {
    CreateAnnotations.context = context;
    AnnotationsController annotationsController = AnnotationsController();
    return AlertDialog(
      title: const Text('Criar anotação'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
              child: Form(
                key: AnnotationsController.formKeyFieldAnnotationTitle,
                child: WidgetTextField().textField(
                    label: 'Título',
                    icon: Icons.wysiwyg,
                    globalKey:
                        AnnotationsController.formKeyFieldAnnotationTitle,
                    controller:
                        AnnotationsController.textEditingControllerTitle,
                    function: (String text) {
                      return annotationsController.validateFieldFormTextTitle(text);
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
                      return annotationsController.validateFieldFormTextAnnotation();
                    },
                ),
              ),
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
            onPressed: function ??
                () async {
                  if(await annotationsController.sendAnnotation(context: context)){
                    Navigator.pop(context);
                  }
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
  AnnotationsController.textEditingControllerAnnotation.text =
      initialValueAnnotation ?? '';
  AnnotationsController.textEditingControllerTitle.text =
      initialValueTitle ?? '';
  await showDialog(
      context: context,
      builder: (contextDialog) {
        return CreateAnnotations(function);
      });
}
