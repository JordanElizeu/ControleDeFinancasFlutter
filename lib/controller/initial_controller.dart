import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/controller/login_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InitialController extends GetxController {
  Future<void> splashScreen(BuildContext context) async {
    Future.delayed(Duration(seconds: 5)).then(
      (value) => {
        LoginController(context).getAuthentication().currentUser != null
            ? Controller()
                .finishAndPageTransition(route: Routes.HOME, context: context)
            : Controller().finishAndPageTransition(
                route: Routes.LOGIN_INITIAL, context: context)
      },
    );
  }
}
