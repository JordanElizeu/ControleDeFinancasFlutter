import 'dart:ui';
import 'package:app_financeiro/controller/initial_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/home/widgets/widget_circleavatar.dart';
import 'package:app_financeiro/ui/home/widgets/widget_textinformative.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageInitial extends StatelessWidget {
  const PageInitial({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (_, constraints) {
          return GetBuilder(
            init: InitialController(),
            builder: (InitialController initialController) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  _containerWithInformationOfAccount(
                      constraints: constraints,
                      initialController: initialController),
                  _cardCircleButtons(
                      initialController: initialController, context: context),
                  _cardLastModifications()
                ],
              ));
            },
          );
        },
      ),
    );
  }
}

Widget _containerWithInformationOfAccount(
    {required BoxConstraints constraints,
    required InitialController initialController}) {
  return Container(
    color: Colors.purple,
    width: constraints.maxWidth,
    height: constraints.maxHeight * 0.25,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25.0,
                child: const Icon(
                  Icons.person_outline,
                  size: 25,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: initialController.changeIconDataEye,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        initialController.getIconData,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: const Icon(
                      Icons.info_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Olá, ${initialController.getUserName()}',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _cardLastModifications() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          textInformative(text: 'Últimas atualizações', fontSize: 22.0),
        ],
      ),
    ),
  );
}

Widget _cardCircleButtons(
    {required InitialController initialController,
    required BuildContext context}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          textInformative(text: 'Conta', fontSize: 22.0),
          textInformative(
              text: initialController.getFormattedValorTotal,
              fontSize: 27.0,
              backgroundColor: initialController.moneyVisible
                  ? Colors.transparent
                  : Colors.black26,
              textColor:
                  initialController.moneyVisible ? null : Colors.transparent,
              fontWeight: FontWeight.w400),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.INCREMENT_MONEY);
                },
                child: circleAvatar(
                  iconData: Icons.arrow_circle_up_rounded,
                  text: "Depositar",
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.DECREMENT_MONEY);
                },
                child: circleAvatar(
                  iconData: Icons.arrow_circle_down,
                  text: "Retirar",
                ),
              ),
              circleAvatar(
                iconData: Icons.assessment_outlined,
                text: "Transações",
              ),
              circleAvatar(
                iconData: Icons.wysiwyg_outlined,
                text: "Anotações",
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
