import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/controller/initial_controller.dart';
import 'package:app_financeiro/controller/login_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/home/widgets/widget_circleavatar.dart';
import 'package:app_financeiro/ui/home/widgets/widget_inkwellicon.dart';
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
    InitialController initialController = InitialController();
    Controller controller = Controller();
    return WillPopScope(
      onWillPop: () => Controller()
          .finishAndPageTransition(route: Routes.HOME, context: context),
      child: SafeArea(
        child: Scaffold(
          body: LayoutBuilder(
            builder: (_, constraints) {
              return GetBuilder(
                init: initialController,
                builder: (InitialController initialController) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _containerWithInformationOfAccount(
                            constraints: constraints,
                            initialController: initialController,
                            context: context),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                textInformative(text: 'Conta', fontSize: 22.0),
                                _cardCircleButtons(
                                    initialController: initialController,
                                    context: context),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: circleAvatar(
                                        function: (){
                                          return controller.pageTransition(
                                              route: Routes.INCREMENT_MONEY,
                                              context: context);
                                        },
                                        iconData:
                                            Icons.arrow_circle_up_rounded,
                                        text: "Depositar",
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: circleAvatar(
                                        function: (){
                                          return controller.pageTransition(
                                              route: Routes.DECREMENT_MONEY,
                                              context: context);
                                        },
                                        iconData: Icons.arrow_circle_down,
                                        text: "Retirar",
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: circleAvatar(
                                        function: (){
                                          return controller.pageTransition(
                                              route: Routes.TRANSACTIONS,
                                              context: context);
                                        },
                                        iconData: Icons.assessment_outlined,
                                        text: "Transações",
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: circleAvatar(
                                        function: (){
                                          return controller.pageTransition(
                                              route: Routes.ANNOTATIONS,
                                              context: context);
                                        },
                                        iconData: Icons.wysiwyg_outlined,
                                        text: "Anotações",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        _cardLastModifications(context)
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _containerWithInformationOfAccount(
    {required BoxConstraints constraints,
    required BuildContext context,
    required InitialController initialController}) {
  return FutureBuilder(
    future: initialController.getUserName(),
    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
      return Container(
        color: Colors.purple,
        width: constraints.maxWidth,
        height: constraints.maxHeight * 0.30,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: 25.0,
                        child: const Icon(
                          Icons.person_outline,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: widgetInkwellIcon(
                        icon: initialController.getIconData,
                        function: () {
                          return initialController.changeIconDataEyeOfMoney();
                        }),
                  ),
                  Expanded(
                    flex: 1,
                    child: widgetInkwellIcon(
                        icon: Icons.info_rounded, function: () {}),
                  ),
                  Expanded(
                    flex: 1,
                    child: widgetInkwellIcon(
                      icon: Icons.logout,
                      function: () {
                        return LoginController(context)
                            .logoutAccount(context: context);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: FittedBox(
                    child: Text(
                      'Olá, ${snapshot.data}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget _cardLastModifications(BuildContext context) {
  return FutureBuilder(
    future: InitialController().getMoneyInFirebase(),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            children: [
              textInformative(
                  text: 'Últimas atualizações ${snapshot.data}',
                  fontSize: 22.0),
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
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.data != null) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return progress();
          case ConnectionState.done:
            return _widgetCircularCard(
                context: context,
                initialController: initialController,
                snapshot: snapshot);
          case ConnectionState.none:
            return error404();
          case ConnectionState.active:
            return progress();
        }
      }
      return progress();
    },
  );
}

Widget _widgetCircularCard(
    {required InitialController initialController,
    required BuildContext context,
    required AsyncSnapshot<String> snapshot}) {
  return Column(
    children: [
      textInformative(
          text: snapshot.data,
          fontSize: 27.0,
          backgroundColor: initialController.moneyVisible
              ? Colors.transparent
              : Colors.black26,
          textColor: initialController.moneyVisible ? null : Colors.transparent,
          fontWeight: FontWeight.w400),
    ],
  );
}
