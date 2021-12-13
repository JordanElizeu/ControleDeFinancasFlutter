import 'package:firebase_auth/firebase_auth.dart';

class ProviderFirebaseExceptions{

  final String _unknownError = "Erro desconhecido";

  String handleFirebaseLoginWithCredentialsException({required FirebaseAuthException exceptionMessage}) {
    final _informationUserDisabled = "O usuário informado está desabilitado.";
    final _informationUserNotFound = "O usuário informado não está cadastrado.";
    final _informationInvalidEmail = "O domínio do e-mail informado é inválido.";
    final _informationWrongPassword = "A senha informada está incorreta.";

    switch(exceptionMessage.code){
      case 'user-disabled':
        return _informationUserDisabled;
      case 'user-not-found':
        return _informationUserNotFound;
      case 'invalid-email':
        return _informationInvalidEmail;
      case 'wrong-password':
        return _informationWrongPassword;
      default:
        return _unknownError;
    }
  }

  String handleFirebaseCreateUserWithEmailAndPasswordException({required FirebaseAuthException exceptionMessage}) {
    final _informationEmailAlreadyInUse = "Já existe uma conta com o endereço de e-mail digitado.";
    final _informationInvalidEmail = "Endereço de e-mail não é válido.";
    final _informationOperationNotAllowed = "Erro no servidor! Entre em contato com o administrador para solução do problema.";
    final _informationWeakPassword = "Senha não é forte o suficiente.";

    switch (exceptionMessage.code){
      case 'email-already-in-use':
        return _informationEmailAlreadyInUse;
      case 'invalid-email':
        return _informationInvalidEmail;
      case 'operation-not-allowed':
        return _informationOperationNotAllowed;
      case 'weak-password':
        return _informationWeakPassword;
      default:
        return _unknownError;
    }
  }

  String handleFirebaseSendPasswordResetEmailException({required FirebaseAuthException exceptionMessage}) {
    final _informationAuthOrEmailInvalid = "Endereço de e-mail inválido.";
    final _informationMissingAndroidPkgName = "Um nome do pacote Android deve ser fornecido se o aplicativo android for necessário para ser instalado.";
    final _informationUrlInvalid = "Url inválida ou inexistente.";
    final _informationMissingIosBundleId = "Erro no servidor! Entre em contato com o desenvolvedor para solução do problema.";
    final _informationUriContinueInvalid = "Url inválido na solicitação de uma nova senha.";
    final _informationUriContinueUnauthorized = "Acesse não autorizado! entre em contato com o desenvolvedor para mais detalhes.";
    final _informationUserNotFound = "não existe usuário correspondente ao endereço de e-mail digitado.";

    switch (exceptionMessage.code){
      case 'auth/invalid-email':
        return _informationAuthOrEmailInvalid;
      case 'auth/missing-android-pkg-name':
        return _informationMissingAndroidPkgName;
      case 'auth/missing-continue-uri':
        return _informationUrlInvalid;
      case 'auth/missing-ios-bundle-id':
        return _informationMissingIosBundleId;
      case 'auth/invalid-continue-uri':
        return _informationUriContinueInvalid;
      case 'auth/unauthorized-continue-uri':
        return _informationUriContinueUnauthorized;
      case 'auth/user-not-found':
        return _informationUserNotFound;
      default:
        return _unknownError;
    }
  }
}