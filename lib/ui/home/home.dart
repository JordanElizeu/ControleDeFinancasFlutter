import 'package:app_financeiro/ui/home/widgets/page_initial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageInitial(),
      )
    );
  }
}
