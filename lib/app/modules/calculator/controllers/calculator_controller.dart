import 'package:get/get.dart';
import '../../../utils/calculator_logic.dart';
import '../../../services/audio_service.dart';
import '../../../services/haptic_service.dart';
import '../../../services/history_service.dart';

class CalculatorController extends GetxController {
  final displayText = '0'.obs;
  final CalculatorLogic _logic = CalculatorLogic();
  final AudioService _audioService = AudioService();
  final HapticService _hapticService = HapticService();
  final HistoryService _historyService = HistoryService();

  @override
  void onInit() {
    super.onInit();
    _audioService.initialize();
  }

  void onButtonPressed(String value) {
    _hapticService.lightImpact();
    _audioService.playButtonSound();
    
    final result = _logic.processInput(value);
    displayText.value = result;
    
    if (value == '=') {
      _historyService.addCalculation(result);
    }
  }

  void clearDisplay() {
    _hapticService.mediumImpact();
    _audioService.playButtonSound();
    _logic.clear();
    displayText.value = '0';
  }

  @override
  void onClose() {
    _audioService.dispose();
    super.onClose();
  }
}
