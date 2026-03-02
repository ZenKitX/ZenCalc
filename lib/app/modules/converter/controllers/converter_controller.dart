import 'package:get/get.dart';
import '../models/conversion_category.dart';
import '../models/conversion_unit.dart';
import '../utils/conversion_logic.dart';

class ConverterController extends GetxController {
  // 当前选择的类别
  final Rx<ConversionCategory?> selectedCategory = Rx<ConversionCategory?>(null);
  
  // 输入值
  final inputValue = ''.obs;
  
  // 输出值
  final outputValue = ''.obs;
  
  // 选择的输入单位
  final Rx<ConversionUnit?> fromUnit = Rx<ConversionUnit?>(null);
  
  // 选择的输出单位
  final Rx<ConversionUnit?> toUnit = Rx<ConversionUnit?>(null);

  /// 选择类别
  void selectCategory(ConversionCategory category) {
    selectedCategory.value = category;
    
    // 设置默认单位
    if (category.units.isNotEmpty) {
      fromUnit.value = category.units[0];
      toUnit.value = category.units.length > 1 ? category.units[1] : category.units[0];
    }
    
    // 清空输入
    inputValue.value = '';
    outputValue.value = '';
  }

  /// 输入数字
  void inputDigit(String digit) {
    // 进制转换特殊处理
    if (selectedCategory.value?.id == 'number_system') {
      // 验证输入是否合法
      final testValue = inputValue.value + digit;
      if (!ConversionLogic.isValidNumberSystemInput(testValue, fromUnit.value?.id ?? 'decimal')) {
        return;
      }
      inputValue.value = testValue;
      _calculate();
      return;
    }

    if (digit == '.' && inputValue.value.contains('.')) return;
    
    inputValue.value += digit;
    _calculate();
  }

  /// 删除最后一位
  void deleteLast() {
    if (inputValue.value.isNotEmpty) {
      inputValue.value = inputValue.value.substring(0, inputValue.value.length - 1);
      _calculate();
    }
  }

  /// 清空
  void clear() {
    inputValue.value = '';
    outputValue.value = '';
  }

  /// 切换输入单位
  void setFromUnit(ConversionUnit unit) {
    fromUnit.value = unit;
    _calculate();
  }

  /// 切换输出单位
  void setToUnit(ConversionUnit unit) {
    toUnit.value = unit;
    _calculate();
  }

  /// 交换单位
  void swapUnits() {
    final temp = fromUnit.value;
    fromUnit.value = toUnit.value;
    toUnit.value = temp;
    
    // 交换数值
    final tempValue = inputValue.value;
    inputValue.value = outputValue.value;
    outputValue.value = tempValue;
  }

  /// 计算换算结果
  void _calculate() {
    if (inputValue.value.isEmpty || fromUnit.value == null || toUnit.value == null) {
      outputValue.value = '';
      return;
    }

    try {
      // 进制转换特殊处理
      if (selectedCategory.value?.id == 'number_system') {
        final result = ConversionLogic.convertNumberSystem(
          value: inputValue.value,
          fromUnitId: fromUnit.value!.id,
          toUnitId: toUnit.value!.id,
        );
        outputValue.value = result;
        return;
      }

      final value = double.parse(inputValue.value);
      double result;

      // 温度特殊处理
      if (selectedCategory.value?.isSpecial == true && selectedCategory.value?.id == 'temperature') {
        result = ConversionLogic.convertTemperature(
          value: value,
          fromUnitId: fromUnit.value!.id,
          toUnitId: toUnit.value!.id,
        );
      } else {
        result = ConversionLogic.convert(
          value: value,
          fromUnit: fromUnit.value!,
          toUnit: toUnit.value!,
        );
      }

      outputValue.value = ConversionLogic.formatResult(result);
    } catch (e) {
      outputValue.value = '';
    }
  }

  /// 返回类别选择
  void backToCategories() {
    selectedCategory.value = null;
    clear();
  }
}
