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
    return WillPopScope(
      onWillPop: () =>
          Controller(context)
              .finishAndPageTransition(route: Routes.LOGIN_INITIAL) ??
          false,
      child: Material(
        child: Center(
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
                additionalSignUpFormDescription:
                    'Por favor, preencha este formulário para completar a inscrição',
                confirmSignupIntro:
                    'Um código de confirmação foi enviado para seu e-mail. Por favor insira o código para confirmar sua conta.',
            ),
            logo: AssetImage('assets/images/foguete.png'),
            onLogin: _loginController.signInFirebase,
            onSignup: _loginController.signUpFirebase,
            logoTag: 'assets/images/foguete.png',
            additionalSignupFields: [
              UserFormField(
                  keyName: 'name',
                  icon: Icon(Icons.person),
                  displayName: 'Name',
                  fieldValidator: validation,
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
              Controller(context).finishAndPageTransition(route: Routes.HOME);
            },
            onRecoverPassword: LoginController(context).forgotPasswordFirebase,
          ),
        ),
      ),
    );
  }
  String? validation(String? text){
    if(text!.length > 20){
      return 'Nome muito grande';
    }
    if(text.isEmpty){
      return 'Digite seu nome';
    }
    return null;
  }
}
