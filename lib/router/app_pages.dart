import 'package:app_financeiro/ui/home/home.dart';
import 'package:app_financeiro/ui/incrementmoney/increment_money.dart';
import 'package:app_financeiro/ui/initial/page_initial.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPagesView{
  static final routes = [
    GetPage(name: Routes.HOME, page: () => Home()),
    GetPage(name: Routes.INITIAL, page: () => PageInitial()),
    GetPage(name: Routes.INCREMENT_MONEY, page: () => IncrementMoney())
  ];
}