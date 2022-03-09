import 'package:app_financeiro/controller/home_controller.dart';
import 'package:app_financeiro/controller/transaction_controller.dart';
import 'package:app_financeiro/injection/injection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/string_i18n.dart';
import 'package:app_financeiro/theme/theme.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_error404.dart';
import 'package:app_financeiro/ui/widgets/widget_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/transition_page.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  final String _appBarTransaction = 'Transações';
  final String _textErrorTransaction = 'Não houve transações';

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController =
        Get.put(getIt.get<TransactionController>());
    final TransitionPage transitionController = getIt.get<TransitionPage>();
    return WillPopScope(
      onWillPop: () => transitionController.finishAndPageTransition(
          route: Routes.HOME, context: context),
      child: Scaffold(
        appBar: appBar(title: _appBarTransaction),
        body: GetBuilder<TransactionController>(
          builder: (_) => FutureBuilder(
            future: _.getAllTransactions(context),
            builder: (BuildContext context,
                AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
              if (snapshot.hasData && snapshot.data!.length > 0) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Error404();
                  case ConnectionState.waiting:
                    return WidgetProgress();
                  case ConnectionState.active:
                    return WidgetProgress();
                  case ConnectionState.done:
                    return _listTile(snapshot, transactionController);
                }
              } else if (snapshot.hasError) {
                return Error404(title: _textErrorTransaction);
              } else if (snapshot.hasData && snapshot.data!.length <= 0) {
                return Error404(title: _textErrorTransaction);
              }
              return WidgetProgress();
            },
          ),
        ),
      ),
    );
  }

  Widget _listTile(AsyncSnapshot<Map> snapshot,
      TransactionController transactionController) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        //this class has how function of remove effect scroll listview
        return true;
      },
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemCount: transactionController.map.length,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Card(
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10, top: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data!['${index}a'][columnDate],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Row(
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
                                  snapshot.data!['${index}a'][columnTitle],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: CircleAvatar(
                                child: Image.asset('assets/images/foguete.png'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            snapshot.data!['${index}a'][columnDescription]),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            '${getIt.get<HomeController>().formatMoney(snapshot.data!['${index}a'][columnMoney])}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: snapshot.data!['${index}a']
                                      [columnIsDeposit]
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Conta:'),
                        subtitle: Text(snapshot.data!['${index}a'][columnRent]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
