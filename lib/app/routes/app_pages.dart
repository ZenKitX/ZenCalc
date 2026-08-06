import 'package:get/get.dart';
import '../modules/calculator/views/calculator_getx_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_getx_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.calculator;

  static final routes = [
    GetPage(name: _Paths.calculator, page: () => const CalculatorView()),
    GetPage(
      name: _Paths.history,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
  ];
}
