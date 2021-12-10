import 'dart:ui';
import 'package:app_financeiro/controller/initial_controller.dart';
import 'package:app_financeiro/ui/initial/widgets/widget_circleavatar.dart';
import 'package:app_financeiro/ui/initial/widgets/widget_textinformative.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageInitial extends StatelessWidget {
  const PageInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return GetBuilder(
          init: InitialController(),
          builder: (InitialController initialController) {
            return Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
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
                                child: Icon(
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
                                    child: Icon(
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
                  ),
                  _cardCircleButtons(initialController: initialController),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: textInformative(text: 'Últimas atualizações', fontSize: 22.0),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

Widget _cardCircleButtons({required InitialController initialController}){
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          textInformative(text: 'Conta', fontSize: 22.0),
          Visibility(
            visible: initialController.moneyVisible,
            child: textInformative(
                text: initialController.getFormattedValorTotal,
                fontSize: 27.0,
                fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              circleAvatar(
                iconData: Icons.arrow_circle_up_rounded,
                text: "Depositar",
              ),
              circleAvatar(
                iconData: Icons.arrow_circle_down,
                text: "Retirar",
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
