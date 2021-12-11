import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Transações'),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
