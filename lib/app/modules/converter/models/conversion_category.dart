import 'package:flutter/material.dart';
import 'conversion_unit.dart';

/// 换算类别模型
class ConversionCategory {
  final String id;
  final String name;
  final IconData icon;
  final List<ConversionUnit> units;
  final bool requiresApi;
  final bool isSpecial; // 特殊换算（如温度、进制）

  const ConversionCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.units,
    this.requiresApi = false,
    this.isSpecial = false,
  });
}
