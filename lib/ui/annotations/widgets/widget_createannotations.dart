import 'package:app_financeiro/controller/annotation_controller.dart';
import 'package:app_financeiro/ui/widgets/widget_validateform.dart';
import 'package:flutter/material.dart';
import '../../../injection/injection.dart';
import '../../../utils/form_validation.dart';

class CreateAnnotations extends StatefulWidget {
  static BuildContext? context;
  final Function()? function;
  final AnnotationsController annotationsController;
  static final GlobalKey<FormState> formKeyAnnotationTitle =
      GlobalKey<FormState>();
  static final GlobalKey<FormState> formKeyAnnotation = GlobalKey<FormState>();

  CreateAnnotations({
    required this.function,
    required this.annotationsController,
  });

  @override
  State<CreateAnnotations> createState() => _CreateAnnotationsState();
}

class _CreateAnnotationsState extends State<CreateAnnotations> {
  final String buttonText = 'Confirmar';

  @override
  Widget build(BuildContext context) {
    CreateAnnotations.context = context;
    AnnotationsController annotationsController =
        getIt.get<AnnotationsController>();
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
                key: CreateAnnotations.formKeyAnnotationTitle,
                child: ValidateForm(
                    label: 'Título',
                    icon: Icons.wysiwyg,
                    globalKey: CreateAnnotations.formKeyAnnotationTitle,
                    controller:
                        annotationsController.textEditingControllerTitle,
                    function: (String text) {
                      return validateFieldFormTextTitle(text: text);
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
              child: Form(
                key: CreateAnnotations.formKeyAnnotation,
                child: ValidateForm(
                    label: 'Anotação',
                    icon: Icons.chat,
                    globalKey: CreateAnnotations.formKeyAnnotation,
                    controller:
                        annotationsController.textEditingControllerAnnotation,
                    function: (String text) {
                      return validateFieldFormTextAnnotation(text: text);
                    }),
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
          onPressed: widget.function ??
              () async {
                if (await annotationsController.sendAnnotation(
                    context: context,
                    annotation: annotationsController
                        .textEditingControllerAnnotation.text,
                    title:
                        annotationsController.textEditingControllerTitle.text,
                    formKeyTitle: CreateAnnotations.formKeyAnnotationTitle,
                    formKeyAnnotation: CreateAnnotations.formKeyAnnotation)) {
                  Navigator.pop(context);
                }
              },
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (CreateAnnotations.formKeyAnnotation.currentState != null) {
      CreateAnnotations.formKeyAnnotation.currentState!.dispose();
    }
    if (CreateAnnotations.formKeyAnnotationTitle.currentState != null) {
      CreateAnnotations.formKeyAnnotationTitle.currentState!.dispose();
    }
  }
}

alertDialogCreateAnnotation({
  required BuildContext context,
  required AnnotationsController annotationsController,
  String? initialValueAnnotation,
  String? initialValueTitle,
  Function()? function,
}) async {
  annotationsController.textEditingControllerAnnotation.text =
      initialValueAnnotation ?? '';
  annotationsController.textEditingControllerTitle.text =
      initialValueTitle ?? '';
  await showDialog(
    context: context,
    builder: (contextDialog) {
      return CreateAnnotations(
        function: function,
        annotationsController: annotationsController,
      );
    },
  );
}
