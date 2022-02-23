import 'package:get_it/get_it.dart';
import 'injection_depedencies.dart';

final getIt = GetIt.I;

void configureDependencies() {
  getIt.registerLazySingleton(() => AnnotationsController());
  getIt.registerLazySingleton(() => DepositMoneyController());
  getIt.registerLazySingleton(() => WithdrawMoneyController());
  getIt.registerLazySingleton(() => TransitionController());
  getIt.registerLazySingleton(() => LoginController());
  getIt.registerLazySingleton(() => HomeController());
  getIt.registerLazySingleton(() => TransactionController());
  getIt.registerLazySingleton(() => InitialController());
  getIt.registerSingleton(RepositoryConnection());
  getIt.registerFactory(
      () => ProviderAnnotations(repositoryConnection: getIt.get()));
  getIt.registerFactory(
      () => ProviderCreateUser(repositoryConnection: getIt.get()));
  getIt.registerFactory(
      () => ProviderTransactions(repositoryConnection: getIt.get()));
  getIt.registerFactory(
      () => ProviderDeposit(repositoryConnection: getIt.get()));
  getIt.registerFactory(
      () => ProviderLoginFirebase(repositoryConnection: getIt.get()));
  getIt.registerFactory(() => ProviderGoogleLogin());
  getIt.registerFactory(
      () => ProviderInformationOfUser(repositoryConnection: getIt.get()));
  getIt.registerFactory(
      () => ProviderWithdraw(repositoryConnection: getIt.get()));
  getIt.registerFactory(() => RepositoryTransactions());
  getIt.registerFactory(() => RepositoryCreateUser());
  getIt.registerFactory(() => RepositoryAnnotations());
  getIt.registerFactory(() => RepositoryDeposit());
  getIt.registerFactory(() => RepositoryFirebaseLogin());
  getIt.registerFactory(() => RepositoryGoogleConnection());
  getIt.registerFactory(() => RepositoryInformationOfUser());
  getIt.registerFactory(() => RepositoryWithdraw());
}
