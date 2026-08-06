import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/converter_controller.dart';
import '../utils/conversion_data.dart';
import 'widgets/category_card.dart';
import 'conversion_detail_view.dart';

/// 单位换算主视图（类别选择）
class ConverterView extends StatelessWidget {
  const ConverterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConverterController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      // 如果选择了类别，显示详情页
      if (controller.selectedCategory.value != null) {
        return ConversionDetailView();
      }

      // 否则显示类别选择
      return Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF1A1A1A)
            : const Color(0xFFE8E4DC),
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
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '单位换算',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // 类别网格
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.5,
                        ),
                    itemCount: ConversionData.categories.length,
                    itemBuilder: (context, index) {
                      final category = ConversionData.categories[index];
                      return CategoryCard(
                        category: category,
                        onTap: () => controller.selectCategory(category),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
