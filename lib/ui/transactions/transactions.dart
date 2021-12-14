import 'package:app_financeiro/controller/initial_controller.dart';
import 'package:app_financeiro/controller/transaction_controller.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/widgets/widget_error404.dart';
import 'package:app_financeiro/ui/widgets/widget_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Transações'),
      body: FutureBuilder(
        future: TransactionController(context).getAllTransactions(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return error404();
              case ConnectionState.waiting:
                return progress();
              case ConnectionState.active:
                return progress();
              case ConnectionState.done:
                return _listTile(snapshot);
            }
          } else if (snapshot.hasError) {
            return error404(title: 'Não houve transações');
          }
          return progress();
        },
      ),
    );
  }

  Widget _listTile(AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: Column(
            children: [
              Card(
                color: Colors.purple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Image.asset('assets/images/foguete.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data!.values.toList().asMap()[index]
                              ['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(snapshot.data!.values.toList().asMap()[index]
                      ['description']),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '${InitialController(context).formatMoney(snapshot.data!.values.toList().asMap()[index]['money'])}',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: snapshot.data!.values.toList().asMap()[index]
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
    );
  }
}
