import 'package:app_financeiro/controller/controller.dart';
import 'package:app_financeiro/controller/login_controller.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetLogin extends StatelessWidget {
  const WidgetLogin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginController _loginController = LoginController(context);
    return Material(
      child: Center(
        child: FlutterLogin(
          logo: AssetImage('assets/images/foguete.png'),
          onLogin: _loginController.signInFirebase,
          onSignup: _loginController.signUpFirebase,
          logoTag: 'assets/images/foguete.png',
          additionalSignupFields: [
            UserFormField(
                keyName: 'name',
                icon: Icon(Icons.person),
                displayName: 'Name',
                userType: LoginUserType.name),
          ],
          loginProviders: [
            LoginProvider(
              icon: FontAwesomeIcons.google,
              label: 'Google',
              callback: () async {
                return await _loginController.signInGoogle();
              },
            ),
          ],
          onSubmitAnimationCompleted: () {
            Controller(context)
                .finishAndPageTransition(route: Routes.HOME);
          },
          onRecoverPassword: LoginController(context).forgotPasswordFirebase,
        ),
      ),
    );
  }
}
