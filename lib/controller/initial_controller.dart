import 'package:app_financeiro/controller/transition_controller.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../injection/injection.dart';

class InitialController extends GetxController {
  Future<void> splashScreen(BuildContext context) async {
    final RepositoryConnection repositoryConnection =
        getIt.get<RepositoryConnection>();
    final FirebaseAuth auth = repositoryConnection.connectionFirebaseAuth();
    final TransitionController transitionController =
        getIt.get<TransitionController>();
    Future.delayed(Duration(seconds: 5)).then(
      (value) => {
        auth.currentUser != null
            ? transitionController.finishAndPageTransition(
                route: Routes.HOME, context: context)
            : transitionController.finishAndPageTransition(
                route: Routes.LOGIN_INITIAL, context: context)
      },
    );
  }
}
