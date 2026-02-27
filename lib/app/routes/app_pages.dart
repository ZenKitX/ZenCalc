import 'package:get/get.dart';
import '../modules/calculator/bindings/calculator_binding.dart';
import '../modules/calculator/views/calculator_getx_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_getx_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CALCULATOR;

  static final routes = [
    GetPage(
      name: _Paths.CALCULATOR,
      page: () => const CalculatorView(),
      binding: CalculatorBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
  ];
}
