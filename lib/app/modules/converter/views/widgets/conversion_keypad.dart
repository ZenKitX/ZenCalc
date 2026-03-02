import 'package:flutter/material.dart';
import '../../controllers/converter_controller.dart';

/// 换算键盘组件
class ConversionKeypad extends StatelessWidget {
  final ConverterController controller;

  const ConversionKeypad({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // 第一行: 7 8 9
          Expanded(
            child: Row(
              children: [
                _buildKey('7', isDark),
                const SizedBox(width: 12),
                _buildKey('8', isDark),
                const SizedBox(width: 12),
                _buildKey('9', isDark),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 第二行: 4 5 6
          Expanded(
            child: Row(
              children: [
                _buildKey('4', isDark),
                const SizedBox(width: 12),
                _buildKey('5', isDark),
                const SizedBox(width: 12),
                _buildKey('6', isDark),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 第三行: 1 2 3
          Expanded(
            child: Row(
              children: [
                _buildKey('1', isDark),
                const SizedBox(width: 12),
                _buildKey('2', isDark),
                const SizedBox(width: 12),
                _buildKey('3', isDark),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 第四行: 00 0 . AC
          Expanded(
            child: Row(
              children: [
                _buildKey('00', isDark),
                const SizedBox(width: 12),
                _buildKey('0', isDark),
                const SizedBox(width: 12),
                _buildKey('.', isDark),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 第五行: AC 和 删除
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildSpecialKey('AC', isDark, () => controller.clear()),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSpecialKey('⌫', isDark, () => controller.deleteLast()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String label, bool isDark) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.inputDigit(label),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE8E4DC),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.5)
                    : Colors.black.withOpacity(0.1),
                offset: const Offset(4, 4),
                blurRadius: 8,
              ),
              BoxShadow(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.white.withOpacity(0.9),
                offset: const Offset(-4, -4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKey(String label, bool isDark, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE8E4DC),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.5)
                  : Colors.black.withOpacity(0.1),
              offset: const Offset(4, 4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.white.withOpacity(0.9),
              offset: const Offset(-4, -4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: label == 'AC' ? Colors.red : (isDark ? Colors.white : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
