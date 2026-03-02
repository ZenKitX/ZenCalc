import 'package:flutter/material.dart';
import '../../models/conversion_unit.dart';

/// 单位选择器组件
class UnitSelector extends StatelessWidget {
  final ConversionUnit? selectedUnit;
  final List<ConversionUnit> units;
  final Function(ConversionUnit) onUnitChanged;
  final bool isDark;

  const UnitSelector({
    super.key,
    required this.selectedUnit,
    required this.units,
    required this.onUnitChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showUnitPicker(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${selectedUnit?.name ?? ''} ${selectedUnit?.symbol ?? ''}',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            color: isDark ? Colors.white60 : Colors.black54,
            size: 20,
          ),
        ],
      ),
    );
  }

  void _showUnitPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 标题
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '选择单位',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const Divider(),
            // 单位列表
            ...units.map((unit) => ListTile(
                  title: Text(
                    '${unit.name} (${unit.symbol})',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  trailing: selectedUnit?.id == unit.id
                      ? const Icon(Icons.check, color: Color(0xFF6B8E23))
                      : null,
                  onTap: () {
                    onUnitChanged(unit);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
