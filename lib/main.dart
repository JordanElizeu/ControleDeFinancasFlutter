import 'package:app_financeiro/router/app_pages.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Future<FirebaseApp> app = Firebase.initializeApp();
  await app.whenComplete(() => {runApp(MyApp())});
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