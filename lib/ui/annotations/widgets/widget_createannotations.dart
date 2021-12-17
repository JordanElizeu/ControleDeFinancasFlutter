import 'package:app_financeiro/controller/annotation_controller.dart';
import 'package:app_financeiro/ui/widgets/widget_validateform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAnnotations extends StatelessWidget {
  final String buttonText = 'Confirmar';
  static BuildContext? context;
  final Function()? function;
  final TextEditingController annotationTextController;
  final TextEditingController titleTextController;
  final GlobalKey<FormState> annotationGlobalKey;
  final GlobalKey<FormState> titleGlobalKey;

  CreateAnnotations(
      {required this.function,
      required this.annotationTextController,
      required this.titleTextController,
      required this.annotationGlobalKey,
      required this.titleGlobalKey});

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
                key: titleGlobalKey,
                child: WidgetTextField().textField(
                    label: 'Título',
                    icon: Icons.wysiwyg,
                    globalKey: titleGlobalKey,
                    controller: titleTextController,
                    function: (String text) {
                      return annotationsController.validateFieldFormTextTitle(
                          text: text);
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
              child: Form(
                key: annotationGlobalKey,
                child: WidgetTextField().textField(
                  label: 'Anotação',
                  icon: Icons.chat,
                  globalKey: annotationGlobalKey,
                  controller: annotationTextController,
                  function: (String text) {
                    return annotationsController
                        .validateFieldFormTextAnnotation(text: text);
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
                  if (await annotationsController.sendAnnotation(
                      context: context,
                      annotation: annotationTextController.text,
                      title: titleTextController.text)) {
                    Navigator.pop(context);
                  }
                })
      ],
    );
  }
}

alertDialogCreateAnnotation({
  required BuildContext context,
  required TextEditingController annotationTextController,
  required TextEditingController titleTextController,
  required GlobalKey<FormState> annotationGlobalKey,
  required GlobalKey<FormState> titleGlobalKey,
  String? initialValueAnnotation,
  String? initialValueTitle,
  Function()? function,
}) async {
  annotationTextController.text = initialValueAnnotation ?? '';
  titleTextController.text = initialValueTitle ?? '';
  await showDialog(
    context: context,
    builder: (contextDialog) {
      return CreateAnnotations(
          titleGlobalKey: titleGlobalKey,
          annotationGlobalKey: annotationGlobalKey,
          titleTextController: titleTextController,
          annotationTextController: annotationTextController,
          function: function);
    },
  );
}
