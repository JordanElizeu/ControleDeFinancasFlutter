import 'package:app_financeiro/controller/financial_rent_controller.dart';
import 'package:app_financeiro/controller/home_controller.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/theme/theme.dart';
import 'package:app_financeiro/ui/financial_rent/widgets/widget_create_rents.dart';
import 'package:app_financeiro/ui/widgets/widget_error404.dart';
import 'package:app_financeiro/ui/widgets/widget_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../string_i18n.dart';
import '../../utils/transition_page.dart';

class FinancialRent extends StatelessWidget {
  const FinancialRent({Key? key}) : super(key: key);

  final String _appBarTitle = 'Fluxo de renda';
  final String _error404 = '0 rendas';
  final String _removingAnnotation = 'Renda removida!';
  final String _cancelRemoveAnnotation = 'Desfazer';

  @override
  Widget build(BuildContext context) {
    final FinancialRentController financialRentController =
        Get.put(getIt.get<FinancialRentController>());
    final TransitionPage transitionPage = getIt.get<TransitionPage>();
    final HomeController homeController = getIt.get<HomeController>();
    return WillPopScope(
      onWillPop: () => transitionPage.finishAndPageTransition(
          route: Routes.HOME, context: context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.account_balance_sharp),
              onPressed: () {
                alertDialogCreateNewRent(
                    context: context,
                    function: () async {
                      await financialRentController.createNewRent(
                        context: context,
                        description: financialRentController
                            .textEditingControllerRentDescription.text,
                        title: financialRentController
                            .textEditingControllerRentTitle.text,
                        formKeyDescription:
                            CreateNewRent.formKeyRentDescription,
                        formKeyTitle: CreateNewRent.formKeyRentTitle,
                        formKeyValueMoney: CreateNewRent.formKeyRentValueMoney,
                      );
                      Navigator.pop(CreateNewRent.context!);
                    },
                    financialRentController: financialRentController,
                    constraints: constraints);
              },
            ),
            appBar: AppBar(
              title: Text(_appBarTitle),
            ),
            body: GetBuilder<FinancialRentController>(
              builder: (controller) => FutureBuilder(
                future: controller.getTodo(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.length > 0) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Error404();
                      case ConnectionState.waiting:
                        return WidgetProgress();
                      case ConnectionState.active:
                        return WidgetProgress();
                      case ConnectionState.done:
                        return _widgetFutureBuilder(
                          snapshot,
                          controller,
                          constraints: constraints,
                          homeController: homeController,
                        );
                    }
                  } else if (snapshot.hasError) {
                    return Error404(title: _error404);
                  } else if (snapshot.data != null && snapshot.data!.isEmpty) {
                    return Error404(title: _error404);
                  }
                  return WidgetProgress();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _widgetFutureBuilder(
    AsyncSnapshot<Map<dynamic, dynamic>> snapshot,
    FinancialRentController financialRentController, {
    required BoxConstraints constraints,
    required HomeController homeController,
  }) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemCount: financialRentController.rentMap.length,
        itemBuilder: (BuildContext context, index) {
          index++;
          bool cancelRemove = false;
          return Dismissible(
            onDismissed: (DismissDirection dismissDirection) {
              Future.delayed(Duration(seconds: 4)).then(
                (value) => {
                  if (!cancelRemove)
                    {
                      financialRentController.removeRent(
                          id: snapshot.data!['${index}a'][columnUid],
                          context: context)
                    }
                },
              );
              financialRentController.rentMap.remove(index);
              final snackBar = SnackBar(
                padding: EdgeInsets.all(10),
                backgroundColor: primaryColor,
                content: Text(
                  _removingAnnotation,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                action: SnackBarAction(
                  textColor: Colors.white,
                  label: _cancelRemoveAnnotation,
                  onPressed: () {
                    cancelRemove = true;
                    financialRentController.recoverRent(
                        map: snapshot.data!['${index}a']);
                  },
                ),
                duration: Duration(seconds: 3),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            key:
                ValueKey(Key(DateTime.now().millisecondsSinceEpoch.toString())),
            background: Card(
              color: Colors.red,
              child: Align(
                alignment: Alignment(-0.9, 0.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Renda: '),
                            Expanded(
                              flex: 4,
                              child: Text(
                                '${snapshot.data!['${index}a'][columnTitle]}',
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  child:
                                      Image.asset('assets/images/foguete.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Text('Descrição: '),
                              Text(
                                '${snapshot.data!['${index}a'][columnDescription]}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: const Text(
                              'Conta: ',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              homeController.formatter.format(double.parse(
                                  snapshot.data!['${index}a']
                                      [columnValueRent])),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.green),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.red))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepOrange)),
                                  onPressed: () {
                                    alertDialogCreateNewRent(
                                        context: context,
                                        initialValueDescription:
                                            snapshot.data!['${index}a']
                                                [columnDescription],
                                        initialValueTitle: snapshot
                                            .data!['${index}a'][columnTitle],
                                        function: () async {
                                          await financialRentController
                                              .editRent(
                                                  id: snapshot
                                                          .data!['${index}a']
                                                      [columnUid],
                                                  context: context,
                                                  index: index);
                                          Navigator.pop(Get.context!);
                                        },
                                        financialRentController:
                                            financialRentController,
                                        constraints: constraints);
                                  },
                                  child: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
