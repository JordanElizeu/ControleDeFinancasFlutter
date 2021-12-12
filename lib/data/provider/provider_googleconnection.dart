import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:app_financeiro/ui/widgets/widget_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProviderGoogleConnection{

  void signInWithGoogle({required BuildContext context}) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential).then((value) =>
          Controller()
              .finishAndPageTransition(context: context, route: Routes.HOME));
    } on FirebaseAuthException catch (exception) {
      alertDialogViewFailure(context: context, function: () {}, titleError: 'Erro inesperado');
    }
  }
}
