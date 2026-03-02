import 'package:flutter/material.dart';
import '../models/conversion_category.dart';
import '../models/conversion_unit.dart';

/// 换算数据定义
class ConversionData {
  /// 长度单位
  static const lengthUnits = [
    ConversionUnit(id: 'meter', name: '米', symbol: 'm', toBaseRatio: 1.0),
    ConversionUnit(id: 'kilometer', name: '千米', symbol: 'km', toBaseRatio: 1000.0),
    ConversionUnit(id: 'centimeter', name: '厘米', symbol: 'cm', toBaseRatio: 0.01),
    ConversionUnit(id: 'millimeter', name: '毫米', symbol: 'mm', toBaseRatio: 0.001),
    ConversionUnit(id: 'foot', name: '英尺', symbol: 'ft', toBaseRatio: 0.3048),
    ConversionUnit(id: 'inch', name: '英寸', symbol: 'in', toBaseRatio: 0.0254),
    ConversionUnit(id: 'yard', name: '码', symbol: 'yd', toBaseRatio: 0.9144),
    ConversionUnit(id: 'mile', name: '英里', symbol: 'mi', toBaseRatio: 1609.344),
  ];

  /// 面积单位
  static const areaUnits = [
    ConversionUnit(id: 'square_meter', name: '平方米', symbol: 'm²', toBaseRatio: 1.0),
    ConversionUnit(id: 'square_kilometer', name: '平方千米', symbol: 'km²', toBaseRatio: 1000000.0),
    ConversionUnit(id: 'square_centimeter', name: '平方厘米', symbol: 'cm²', toBaseRatio: 0.0001),
    ConversionUnit(id: 'hectare', name: '公顷', symbol: 'ha', toBaseRatio: 10000.0),
    ConversionUnit(id: 'mu', name: '亩', symbol: '亩', toBaseRatio: 666.67),
    ConversionUnit(id: 'square_foot', name: '平方英尺', symbol: 'ft²', toBaseRatio: 0.092903),
    ConversionUnit(id: 'square_mile', name: '平方英里', symbol: 'mi²', toBaseRatio: 2589988.11),
  ];

  /// 重量单位
  static const weightUnits = [
    ConversionUnit(id: 'kilogram', name: '千克', symbol: 'kg', toBaseRatio: 1.0),
    ConversionUnit(id: 'gram', name: '克', symbol: 'g', toBaseRatio: 0.001),
    ConversionUnit(id: 'milligram', name: '毫克', symbol: 'mg', toBaseRatio: 0.000001),
    ConversionUnit(id: 'ton', name: '吨', symbol: 't', toBaseRatio: 1000.0),
    ConversionUnit(id: 'pound', name: '磅', symbol: 'lb', toBaseRatio: 0.453592),
    ConversionUnit(id: 'ounce', name: '盎司', symbol: 'oz', toBaseRatio: 0.0283495),
    ConversionUnit(id: 'jin', name: '斤', symbol: '斤', toBaseRatio: 0.5),
    ConversionUnit(id: 'liang', name: '两', symbol: '两', toBaseRatio: 0.05),
  ];

  /// 温度单位（特殊处理，不使用 toBaseRatio）
  static const temperatureUnits = [
    ConversionUnit(id: 'celsius', name: '摄氏度', symbol: '°C', toBaseRatio: 1.0),
    ConversionUnit(id: 'fahrenheit', name: '华氏度', symbol: '°F', toBaseRatio: 1.0),
    ConversionUnit(id: 'kelvin', name: '开尔文', symbol: 'K', toBaseRatio: 1.0),
  ];

  /// 所有类别
  static final categories = [
    const ConversionCategory(
      id: 'length',
      name: '长度',
      icon: Icons.straighten,
      units: lengthUnits,
    ),
    const ConversionCategory(
      id: 'area',
      name: '面积',
      icon: Icons.crop_square,
      units: areaUnits,
    ),
    const ConversionCategory(
      id: 'weight',
      name: '重量',
      icon: Icons.fitness_center,
      units: weightUnits,
    ),
    const ConversionCategory(
      id: 'temperature',
      name: '温度',
      icon: Icons.thermostat,
      units: temperatureUnits,
      isSpecial: true,
    ),
  ];
}
