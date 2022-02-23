import 'package:app_financeiro/controller/home_controller.dart';
import 'package:app_financeiro/controller/login_controller.dart';
import 'package:app_financeiro/controller/transaction_controller.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/string_i18n.dart';
import 'package:app_financeiro/theme/theme.dart';
import 'package:app_financeiro/ui/home/widgets/widget_circleavatar.dart';
import 'package:app_financeiro/ui/home/widgets/widget_inkwellicon.dart';
import 'package:app_financeiro/ui/home/widgets/widget_textinformative.dart';
import 'package:app_financeiro/ui/widgets/widget_error404.dart';
import 'package:app_financeiro/ui/widgets/widget_logout.dart';
import 'package:app_financeiro/ui/widgets/widget_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/transition_page.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  final String _textAccount = 'Conta';
  final String _textCircleAvatarDeposit = "Depositar";
  final String _textCircleAvatarWithdraw = 'Retirar';
  final String _textCircleAvatarTransaction = 'Transações';
  final String _textCircleAvatarAnnotation = 'Anotações';

  @override
  Widget build(BuildContext context) {
    Get.put(getIt.get<TransactionController>());
    Get.put(getIt.get<HomeController>());
    TransitionPage controller = getIt.get<TransitionPage>();
    return WillPopScope(
      onWillPop: () => alertDialogViewSuccess(context: context),
      child: SafeArea(
        child: Scaffold(
          body: LayoutBuilder(
            builder: (_, constraints) {
              return ListView(
                children: [
                  _containerWithInformationOfAccount(
                      constraints: constraints, context: context),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          WidgetTextInformative(
                            text: _textAccount,
                            fontSize: 22.0,
                            constraints: constraints,
                          ),
                          _cardCircleButtons(
                            context: context,
                            constraints: constraints,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: WidgetCircleAvatar(
                                  function: () {
                                    return controller.finishAndPageTransition(
                                        route: Routes.INCREMENT_MONEY,
                                        context: context);
                                  },
                                  iconData: Icons.arrow_circle_up_rounded,
                                  text: _textCircleAvatarDeposit,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: WidgetCircleAvatar(
                                  function: () {
                                    return controller.finishAndPageTransition(
                                        route: Routes.DECREMENT_MONEY,
                                        context: context);
                                  },
                                  iconData: Icons.arrow_circle_down,
                                  text: _textCircleAvatarWithdraw,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: WidgetCircleAvatar(
                                  function: () {
                                    return controller.finishAndPageTransition(
                                        route: Routes.TRANSACTIONS,
                                        context: context);
                                  },
                                  iconData: Icons.assessment_outlined,
                                  text: _textCircleAvatarTransaction,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: WidgetCircleAvatar(
                                  function: () {
                                    return controller.finishAndPageTransition(
                                        route: Routes.ANNOTATIONS,
                                        context: context);
                                  },
                                  iconData: Icons.wysiwyg_outlined,
                                  text: _textCircleAvatarAnnotation,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  _cardLastModifications(
                    context: context,
                    constraints: constraints,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _containerWithInformationOfAccount(
    {required BoxConstraints constraints, required BuildContext context}) {
  final String _loading = 'carregando...';
  final LoginController loginController = getIt.get<LoginController>();

  return GetBuilder<HomeController>(
    builder: (_) => FutureBuilder(
      initialData: _loading,
      future: _.getUserName(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        return Container(
          color: primaryColor,
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
                      child: WidgetInkwellIcon(
                        icon: _.iconData,
                        function: () {
                          return _.changeIconDataEyeOfMoney();
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: WidgetInkwellIcon(
                          icon: Icons.info_rounded, function: () {}),
                    ),
                    Expanded(
                      flex: 1,
                      child: WidgetInkwellIcon(
                        icon: Icons.logout,
                        function: () {
                          return loginController.logoutAccount(
                              context: context);
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
                        'Olá, ${snapshot.data ?? ''}',
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
    ),
  );
}

Widget _cardLastModifications({
  required BuildContext context,
  required BoxConstraints constraints,
}) {
  final String _lastTransaction = 'Últimas transações';
  final HomeController homeController = getIt.get<HomeController>();

  return GetBuilder<TransactionController>(
    builder: (_) => FutureBuilder(
      future: _.getAllTransactions(context),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData && snapshot.data!.length > 0) {
          int position = snapshot.data!.length - 4;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return WidgetProgress();
            case ConnectionState.waiting:
              return WidgetProgress();
            case ConnectionState.active:
              return WidgetProgress();
            case ConnectionState.done:
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      title: WidgetTextInformative(
                        text: _lastTransaction,
                        constraints: constraints,
                        fontSize: 22.0,
                      ),
                    ),
                    NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.length > 3
                            ? 3
                            : position = snapshot.data!.length,
                        itemBuilder: (BuildContext context, index) {
                          if (position == snapshot.data!.length) {
                            position = index;
                          } else {
                            position++;
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Card(
                                  color: primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 0,
                                          child: CircleAvatar(
                                            child: Icon(Icons.person),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data!['${position}a']
                                                      [columnTitle]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 0,
                                          child: CircleAvatar(
                                            child: Image.asset(
                                                'assets/images/foguete.png'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    title: Text(snapshot.data!['${position}a']
                                            [columnDescription]
                                        .toString()),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        '${homeController.formatMoney(snapshot.data!['${position}a'][columnMoney])}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color:
                                                snapshot.data!['${position}a']
                                                        [columnIsDeposit]
                                                    ? Colors.green
                                                    : Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
          }
        } else if (snapshot.hasError) {
          return Error404(title: 'Não houve transações');
        } else if (snapshot.hasData && snapshot.data!.length <= 0) {
          return Error404(title: 'Não houve transações');
        }
        return WidgetProgress();
      },
    ),
  );
}

Widget _cardCircleButtons({
  required BuildContext context,
  required BoxConstraints constraints,
}) {
  return GetBuilder<HomeController>(builder: (_) {
    if (_.moneyValueFormatted() != null) {
      return _widgetCircularCard(
        homeController: _,
        constraints: constraints,
      );
    } else {
      return FutureBuilder(
        future: _.getMoneyInFirebase(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.data != null) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return WidgetProgress();
              case ConnectionState.done:
                return _widgetCircularCard(
                  snapshot: snapshot,
                  homeController: _,
                  constraints: constraints,
                );
              case ConnectionState.none:
                return Error404();
              case ConnectionState.active:
                return WidgetProgress();
            }
          }
          return WidgetProgress();
        },
      );
    }
  });
}

Widget _widgetCircularCard({
  required HomeController homeController,
  required BoxConstraints constraints,
  AsyncSnapshot<String>? snapshot,
}) {
  return WidgetTextInformative(
      text: homeController.moneyValueFormatted() ?? snapshot!.data,
      fontSize: 27.0,
      constraints: constraints,
      backgroundColor:
          homeController.moneyVisible ? Colors.white : Colors.black26,
      textColor: homeController.moneyVisible ? null : Colors.transparent,
      fontWeight: FontWeight.w400);
}
