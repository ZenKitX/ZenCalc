import 'package:get/get.dart';
import 'package:zen_calc/app/services/history_service.dart';
import 'package:zen_calc/app/data/models/calculation_history.dart';

class HistoryController extends GetxController {
  final history = <CalculationHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  void loadHistory() {
    history.value = HistoryService.history;
  }

  void clearHistory() async {
    await HistoryService.clearHistory();
    history.clear();
  }
}
