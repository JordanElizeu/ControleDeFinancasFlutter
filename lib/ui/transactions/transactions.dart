import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/controller/initial_controller.dart';
import 'package:app_financeiro/controller/transaction_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_error404.dart';
import 'package:app_financeiro/ui/widgets/widget_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TransactionController transactionController =
        Get.put(TransactionController());
    return WillPopScope(
      onWillPop: () => Controller()
          .finishAndPageTransition(route: Routes.HOME, context: context),
      child: Scaffold(
        appBar: appBar(title: 'Transações'),
        body: GetBuilder<TransactionController>(
          builder: (_) => FutureBuilder(
            future: _.getAllTransactions(context),
            builder: (BuildContext context,
                AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
              if (snapshot.hasData && snapshot.data!.length > 0) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return error404();
                  case ConnectionState.waiting:
                    return progress();
                  case ConnectionState.active:
                    return progress();
                  case ConnectionState.done:
                    return _listTile(snapshot, transactionController);
                }
              } else if (snapshot.hasError) {
                return error404(title: 'Não houve transações');
              } else if (snapshot.hasData && snapshot.data!.length <= 0){
                return error404(title: 'Não houve transações');
              }
              return progress();
            },
          ),
        ),
      ),
    );
  }

//this class has how function of remove effect scroll listview
  Widget _listTile(AsyncSnapshot<Map> snapshot,
      TransactionController transactionController) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowGlow();
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
                  color: Colors.purple,
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
                              snapshot.data!['${index}a']
                                  ['title'],
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
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(snapshot.data!['${index}a']
                        ['description']),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        '${InitialController().formatMoney(snapshot.data!['${index}a']['money'])}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: snapshot.data!['${index}a']
                                    ['is_deposit']
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
    );
  }
}
