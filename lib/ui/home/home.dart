import 'package:app_financeiro/ui/home/widgets/widget_appbar.dart';
import 'package:app_financeiro/ui/home/widgets/widget_body.dart';
import 'package:app_financeiro/ui/home/widgets/widget_navigationbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: Drawer(),
      bottomNavigationBar: navigationBar(),
      body: bodyHome()
    );
  }
}
