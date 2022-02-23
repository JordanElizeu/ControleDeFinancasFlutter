import 'package:app_financeiro/router/app_pages.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'injection/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Future<FirebaseApp> app = Firebase.initializeApp();
  await app.whenComplete(() => {runApp(MyApp())});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routes: AppPagesView.routes,
      initialRoute: Routes.INITIAL,
    );
  }
}
