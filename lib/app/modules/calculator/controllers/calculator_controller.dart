import 'package:get/get.dart';

class CalculatorController extends GetxController {
  final displayText = '0'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onButtonPressed(String value) {
    // 这个 controller 不会被使用
    // 实际逻辑在 calculator_view.dart 的 StatefulWidget 中
  }

  void clearDisplay() {
    displayText.value = '0';
  }
}
