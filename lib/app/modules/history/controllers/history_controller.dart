import 'package:get/get.dart';
import '../../../services/history_service.dart';
import '../../../data/models/calculation_history.dart';

class HistoryController extends GetxController {
  final HistoryService _historyService = HistoryService();
  final history = <CalculationHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  void loadHistory() async {
    final items = await _historyService.getHistory();
    history.value = items;
  }

  void clearHistory() async {
    await _historyService.clearHistory();
    history.clear();
  }
}
