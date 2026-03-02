import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/converter_controller.dart';
import 'widgets/unit_selector.dart';
import 'widgets/conversion_keypad.dart';

/// 换算详情视图
class ConversionDetailView extends StatelessWidget {
  const ConversionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConverterController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE8E4DC);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部标题栏
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                    onPressed: () => controller.backToCategories(),
                  ),
                  const SizedBox(width: 8),
                  Obx(() => Text(
                        '${controller.selectedCategory.value?.name ?? ''}换算',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      )),
                ],
              ),
            ),

            // 换算卡片区域
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    // 左侧：输入和输出卡片
                    Expanded(
                      child: Column(
                        children: [
                          // 输入卡片
                          Expanded(
                            child: _buildInputCard(controller, isDark),
                          ),
                          const SizedBox(height: 16),
                          // 输出卡片
                          Expanded(
                            child: _buildOutputCard(controller, isDark),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // 右侧：交换按钮
                    _buildSwapButton(controller, isDark),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 键盘
            Expanded(
              flex: 4,
              child: ConversionKeypad(controller: controller),
            ),
          ],
        ),
      ),
    );
  }

  /// 输入卡片
  Widget _buildInputCard(ConverterController controller, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 单位选择器
          Obx(() => UnitSelector(
                selectedUnit: controller.fromUnit.value,
                units: controller.selectedCategory.value?.units ?? [],
                onUnitChanged: (unit) => controller.setFromUnit(unit),
                isDark: isDark,
              )),
          const Spacer(),
          // 输入值
          Obx(() => Text(
                controller.inputValue.value.isEmpty ? '0' : controller.inputValue.value,
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFFFF6B35),
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
        ],
      ),
    );
  }

  /// 交换按钮
  Widget _buildSwapButton(ConverterController controller, bool isDark) {
    return GestureDetector(
      onTap: () => controller.swapUnits(),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.08),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(
          Icons.swap_vert,
          color: const Color(0xFF6B8E23),
          size: 28,
        ),
      ),
    );
  }

  /// 输出卡片
  Widget _buildOutputCard(ConverterController controller, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 单位选择器
          Obx(() => UnitSelector(
                selectedUnit: controller.toUnit.value,
                units: controller.selectedCategory.value?.units ?? [],
                onUnitChanged: (unit) => controller.setToUnit(unit),
                isDark: isDark,
              )),
          const Spacer(),
          // 输出值
          Obx(() => Text(
                controller.outputValue.value.isEmpty ? '0' : controller.outputValue.value,
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w300,
                  color: isDark ? Colors.white : Colors.black87,
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
        ],
      ),
    );
  }
}
