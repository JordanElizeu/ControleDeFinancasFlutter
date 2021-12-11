import 'package:app_financeiro/router/app_pages.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: Routes.HOME,
      routes: AppPagesView.routes,
    );
  }
}