import 'package:app_financeiro/data/provider/firebase/provider_createuser.dart';
import 'package:app_financeiro/data/provider/firebase/provider_informationsofuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProviderGoogleLogin {
  Future<String?> signInWithGoogle(
      {required BuildContext context,
      required ProviderCreateUser providerCreateUser,
      required ProviderInformationOfUser providerInformationOfUser}) async {
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
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!await userExists(providerInformationOfUser)) {
        providerCreateUser.providerCreateUserGoogle();
      }

      return null;
    } catch (exception) {
      return 'Erro! Login falhou';
    }
  }

  Future<bool> userExists(
      ProviderInformationOfUser providerInformationOfUser) async {
    final String? name =
        await providerInformationOfUser.providerGetNameIfUserIsFromFirebase();
    if (name != null) {
      return true;
    }
    return false;
  }
}
