import 'package:app_financeiro/controller/transition_controller.dart';
import 'package:app_financeiro/controller/login_controller.dart';
import 'package:app_financeiro/data/repository/firebase/repository_connection.dart';
import 'package:app_financeiro/router/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../injection/injection.dart';

class WidgetLogin extends StatelessWidget {
  const WidgetLogin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.put(getIt.get<LoginController>());
    FirebaseAuth auth =
        getIt.get<RepositoryConnection>().connectionFirebaseAuth();
    TransitionController transitionController =
        getIt.get<TransitionController>();
    return WillPopScope(
      onWillPop: () => transitionController.finishAndPageTransition(
          route: Routes.LOGIN_INITIAL, context: context),
      child: Material(
        child: FlutterLogin(
          messages: LoginMessages(
            forgotPasswordButton: 'Esqueci minha senha',
            signupButton: 'Cadastre-se',
            signUpSuccess: 'Conta criada com sucesso!',
            loginButton: 'Entrar',
            passwordHint: 'Senha',
            confirmPasswordHint: 'Confirme a senha',
            goBackButton: 'Voltar',
            providersTitleFirst: 'ou continue com',
            confirmPasswordError: 'Senhas não coincidem',
            recoverPasswordIntro: 'Redefina sua senha aqui',
            recoverPasswordDescription:
                'Enviaremos sua senha em um texto simples para esta conta de e-mail.',
            recoverPasswordSuccess:
                'Enviamos um email para o seu endereço eletrônico',
            recoverPasswordButton: 'Redefinir',
            recoverCodePasswordDescription:
                'Enviaremos um código de recuperação de senha para o seu e-mail.',
            flushbarTitleError: 'Erro',
            flushbarTitleSuccess: 'Sucesso',
            additionalSignUpSubmitButton: 'Confirmar',
            additionalSignUpFormDescription:
                'Por favor, preencha este formulário para completar a inscrição',
            confirmSignupIntro:
                'Um código de confirmação foi enviado para seu e-mail. Por favor insira o código para confirmar sua conta.',
          ),
          logo: AssetImage('assets/images/foguete.png'),
          onLogin: _loginController.signInFirebase,
          onSignup: _loginController.signUpFirebase,
          savedEmail:
              '${auth.currentUser != null ? transitionController.finishAndPageTransition(route: Routes.HOME, context: context) : ''}',
          logoTag: 'assets/images/foguete.png',
          additionalSignupFields: [
            UserFormField(
                keyName: 'name',
                icon: Icon(Icons.person),
                displayName: 'Name',
                fieldValidator: _loginController.validation,
                userType: LoginUserType.name),
          ],
          loginProviders: [
            LoginProvider(
              icon: FontAwesomeIcons.google,
              label: 'Google',
              callback: () async {
                return await _loginController.signInGoogle(context: context);
              },
            ),
          ],
          onSubmitAnimationCompleted: () {
            transitionController.finishAndPageTransition(
                route: Routes.HOME, context: context);
          },
          onRecoverPassword: _loginController.forgotPasswordFirebase,
        ),
      ),
    );
  }
}
