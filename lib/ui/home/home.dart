import 'package:app_financeiro/ui/initial/page_initial.dart';
import 'package:app_financeiro/ui/widgets/widget_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Finances Everyday'),
      body: Container(
        child: PageInitial(),
      )
    );
  }
}
