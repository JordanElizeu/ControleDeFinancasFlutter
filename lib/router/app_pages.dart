import 'package:app_financeiro/ui/annotations/annotations.dart';
import 'package:app_financeiro/ui/deposit_money/deposit_money.dart';
import 'package:app_financeiro/ui/home/home.dart';
import 'package:app_financeiro/ui/home/widgets/page_initial.dart';
import 'package:app_financeiro/ui/withdraw_money/withdraw_money.dart';
import 'app_routes.dart';

class AppPagesView{
  static final routes = {
    Routes.HOME: (_) => Home(),
    Routes.INITIAL: (_) => PageInitial(),
    Routes.INCREMENT_MONEY: (_) => DepositMoney(),
    Routes.DECREMENT_MONEY: (_) => WithdrawMoney(),
    Routes.ANNOTATIONS: (_) => Annotations(),
  };
}