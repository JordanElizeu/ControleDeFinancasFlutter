import 'package:app_financeiro/ui/home/home.dart';
import 'package:app_financeiro/ui/incrementmoney/increment_money.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: IncrementMoney(),
    );
  }
}