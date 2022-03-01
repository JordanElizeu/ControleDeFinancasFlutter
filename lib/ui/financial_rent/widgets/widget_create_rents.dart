import 'package:app_financeiro/ui/widgets/widget_validateform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
import 'package:get/get.dart';
import '../../../controller/financial_rent_controller.dart';
import '../../../injection/injection.dart';
import '../../../utils/form_validation.dart';

class CreateNewRent extends StatefulWidget {
  static BuildContext? context;
  final Function()? function;
  final BoxConstraints constraints;
  final FinancialRentController financialRentController;
  static final GlobalKey<FormState> formKeyRentTitle = GlobalKey<FormState>();
  static final GlobalKey<FormState> formKeyRentValueMoney =
      GlobalKey<FormState>();
  static final GlobalKey<FormState> formKeyRentDescription =
      GlobalKey<FormState>();

  CreateNewRent(
      {required this.function,
      required this.financialRentController,
      required this.constraints});

  @override
  State<CreateNewRent> createState() => _CreateNewRentState();
}

class _CreateNewRentState extends State<CreateNewRent> {
  final String buttonText = 'Confirmar';

  @override
  Widget build(BuildContext context) {
    CreateNewRent.context = context;
    final FinancialRentController financialRentController =
        getIt.get<FinancialRentController>();
    return AlertDialog(
      title: const Text('Adicionar nova renda'),
      content: SizedBox(
        width: widget.constraints.maxWidth * 0.80,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                child: Form(
                  key: CreateNewRent.formKeyRentTitle,
                  child: ValidateForm(
                      label: 'Nome da renda',
                      icon: Icons.monetization_on,
                      globalKey: CreateNewRent.formKeyRentTitle,
                      controller: financialRentController
                          .textEditingControllerRentTitle,
                      function: (String text) {
                        return validateFieldFormTextTitle(text: text);
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                child: Form(
                  key: CreateNewRent.formKeyRentDescription,
                  child: ValidateForm(
                    label: 'Descrição',
                    icon: Icons.chat,
                    globalKey: CreateNewRent.formKeyRentDescription,
                    controller: financialRentController
                        .textEditingControllerRentDescription,
                    function: (String text) {
                      return validateFieldFormTextDesc(text);
                    },
                  ),
                ),
              ),
              GetBuilder<FinancialRentController>(
                builder: (controller) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Checkbox(
                              value: controller.addRentWithValueInitial,
                              onChanged: (value) {
                                print(value);
                                controller.changeAddRentWithValueInitial(
                                    value: value!);
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 11,
                            child: const Text('Já possuo valor na conta'),
                          )
                        ],
                      ),
                      Visibility(
                        visible: controller.addRentWithValueInitial,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 16.0, top: 16.0),
                          child: Form(
                            key: CreateNewRent.formKeyRentValueMoney,
                            child: ValidateForm(
                              label: 'Adicionar valor',
                              icon: Icons.monetization_on,
                              textInputType: TextInputType.number,
                              moneyInputFormatter: MoneyInputFormatter(
                                leadingSymbol: 'R\$',
                                useSymbolPadding: true,
                                thousandSeparator: ThousandSeparator.Period,
                              ),
                              globalKey: CreateNewRent.formKeyRentValueMoney,
                              controller: controller
                                  .textEditingControllerRentValueMoney,
                              function: (String text) {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
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
                if (await financialRentController.createNewRent(
                    context: context,
                    description: financialRentController
                        .textEditingControllerRentDescription.text,
                    title: financialRentController
                        .textEditingControllerRentTitle.text,
                    formKeyTitle: CreateNewRent.formKeyRentTitle,
                    formKeyDescription: CreateNewRent.formKeyRentDescription,
                    formKeyValueMoney: CreateNewRent.formKeyRentValueMoney)) {
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
    if (CreateNewRent.formKeyRentDescription.currentState != null) {
      CreateNewRent.formKeyRentDescription.currentState!.dispose();
    }
    if (CreateNewRent.formKeyRentTitle.currentState != null) {
      CreateNewRent.formKeyRentTitle.currentState!.dispose();
    }
  }
}

alertDialogCreateNewRent({
  required BuildContext context,
  required BoxConstraints constraints,
  required FinancialRentController financialRentController,
  String? initialValueDescription,
  String? initialValueTitle,
  Function()? function,
}) async {
  financialRentController.textEditingControllerRentDescription.text =
      initialValueDescription ?? '';
  financialRentController.textEditingControllerRentTitle.text =
      initialValueTitle ?? '';
  await showDialog(
    context: context,
    builder: (contextDialog) {
      return CreateNewRent(
        function: function,
        financialRentController: financialRentController,
        constraints: constraints,
      );
    },
  );
}
