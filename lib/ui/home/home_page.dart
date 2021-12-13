import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/controller/initial_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/home/widgets/widget_circleavatar.dart';
import 'package:app_financeiro/ui/home/widgets/widget_textinformative.dart';
import 'package:app_financeiro/ui/widgets/widget_error404.dart';
import 'package:app_financeiro/ui/widgets/widget_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
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
                    onTap: initialController.changeIconDataEyeOfMoney,
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
  return FutureBuilder(
    future: InitialController().getMoneyInFirebase(),
    initialData: "Loading text..",
    builder: (BuildContext context, AsyncSnapshot<String> text) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              textInformative(
                  text: 'Últimas atualizações ${text.data}', fontSize: 22.0),
            ],
          ),
        ),
      );
    },
  );
}

Widget _cardCircleButtons(
    {required InitialController initialController,
    required BuildContext context}) {
  return FutureBuilder(
    future: InitialController().getMoneyInFirebase(),
    initialData: 'Loading text..',
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      switch (snapshot.connectionState){
        case ConnectionState.waiting:
          return progress();
        case ConnectionState.done:
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  textInformative(text: 'Conta', fontSize: 22.0),
                  textInformative(
                      text: snapshot.data,
                      fontSize: 27.0,
                      backgroundColor: initialController.moneyVisible
                          ? Colors.transparent
                          : Colors.black26,
                      textColor: initialController.moneyVisible
                          ? null
                          : Colors.transparent,
                      fontWeight: FontWeight.w400),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Controller().pageTransition(
                              context: context, route: Routes.INCREMENT_MONEY);
                        },
                        child: circleAvatar(
                          iconData: Icons.arrow_circle_up_rounded,
                          text: "Depositar",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Controller().pageTransition(
                              context: context, route: Routes.DECREMENT_MONEY);
                        },
                        child: circleAvatar(
                          iconData: Icons.arrow_circle_down,
                          text: "Retirar",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Controller().pageTransition(
                              context: context, route: Routes.TRANSACTIONS);
                        },
                        child: circleAvatar(
                          iconData: Icons.assessment_outlined,
                          text: "Transações",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Controller().pageTransition(
                              context: context, route: Routes.ANNOTATIONS);
                        },
                        child: circleAvatar(
                          iconData: Icons.wysiwyg_outlined,
                          text: "Anotações",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        case ConnectionState.none:
          return error404();
        case ConnectionState.active:
          return progress();
      }
    },
  );
}
