import 'package:app_financeiro/ui/annotations/annotations.dart';
import 'package:app_financeiro/ui/deposit_money/deposit_money.dart';
import 'package:app_financeiro/ui/home/home_page.dart';
import 'package:app_financeiro/ui/initial/initial_page.dart';
import 'package:app_financeiro/ui/login/login_page.dart';
import 'package:app_financeiro/ui/transactions/transactions.dart';
import 'package:app_financeiro/ui/withdraw_money/withdraw_money.dart';
import '../ui/financial_rent/financial_rent.dart';
import 'app_routes.dart';

class AppPagesView {
  static final routes = {
    Routes.INITIAL: (_) => PageInitial(),
    Routes.HOME: (_) => PageHome(),
    Routes.INCREMENT_MONEY: (_) => DepositMoney(),
    Routes.DECREMENT_MONEY: (_) => WithdrawMoney(),
    Routes.ANNOTATIONS: (_) => Annotations(),
    Routes.TRANSACTIONS: (_) => Transactions(),
    Routes.LOGIN: (_) => LoginPage(),
    Routes.FINANCIAL_RENT: (_) => FinancialRent(),
  };
}
