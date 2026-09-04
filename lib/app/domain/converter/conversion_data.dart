import 'package:flutter/material.dart';
import 'conversion_category.dart';
import 'conversion_unit.dart';

/// 换算数据定义
class ConversionData {
  /// 长度单位
  static const lengthUnits = [
    ConversionUnit(id: 'meter', name: '米', symbol: 'm', toBaseRatio: 1.0),
    ConversionUnit(
      id: 'kilometer',
      name: '千米',
      symbol: 'km',
      toBaseRatio: 1000.0,
    ),
    ConversionUnit(
      id: 'centimeter',
      name: '厘米',
      symbol: 'cm',
      toBaseRatio: 0.01,
    ),
    ConversionUnit(
      id: 'millimeter',
      name: '毫米',
      symbol: 'mm',
      toBaseRatio: 0.001,
    ),
    ConversionUnit(id: 'foot', name: '英尺', symbol: 'ft', toBaseRatio: 0.3048),
    ConversionUnit(id: 'inch', name: '英寸', symbol: 'in', toBaseRatio: 0.0254),
    ConversionUnit(id: 'yard', name: '码', symbol: 'yd', toBaseRatio: 0.9144),
    ConversionUnit(id: 'mile', name: '英里', symbol: 'mi', toBaseRatio: 1609.344),
  ];

  /// 面积单位
  static const areaUnits = [
    ConversionUnit(
      id: 'square_meter',
      name: '平方米',
      symbol: 'm²',
      toBaseRatio: 1.0,
    ),
    ConversionUnit(
      id: 'square_kilometer',
      name: '平方千米',
      symbol: 'km²',
      toBaseRatio: 1000000.0,
    ),
    ConversionUnit(
      id: 'square_centimeter',
      name: '平方厘米',
      symbol: 'cm²',
      toBaseRatio: 0.0001,
    ),
    ConversionUnit(
      id: 'hectare',
      name: '公顷',
      symbol: 'ha',
      toBaseRatio: 10000.0,
    ),
    ConversionUnit(id: 'mu', name: '亩', symbol: '亩', toBaseRatio: 666.67),
    ConversionUnit(
      id: 'square_foot',
      name: '平方英尺',
      symbol: 'ft²',
      toBaseRatio: 0.092903,
    ),
    ConversionUnit(
      id: 'square_mile',
      name: '平方英里',
      symbol: 'mi²',
      toBaseRatio: 2589988.11,
    ),
  ];

  /// 重量单位
  static const weightUnits = [
    ConversionUnit(id: 'kilogram', name: '千克', symbol: 'kg', toBaseRatio: 1.0),
    ConversionUnit(id: 'gram', name: '克', symbol: 'g', toBaseRatio: 0.001),
    ConversionUnit(
      id: 'milligram',
      name: '毫克',
      symbol: 'mg',
      toBaseRatio: 0.000001,
    ),
    ConversionUnit(id: 'ton', name: '吨', symbol: 't', toBaseRatio: 1000.0),
    ConversionUnit(id: 'pound', name: '磅', symbol: 'lb', toBaseRatio: 0.453592),
    ConversionUnit(
      id: 'ounce',
      name: '盎司',
      symbol: 'oz',
      toBaseRatio: 0.0283495,
    ),
    ConversionUnit(id: 'jin', name: '斤', symbol: '斤', toBaseRatio: 0.5),
    ConversionUnit(id: 'liang', name: '两', symbol: '两', toBaseRatio: 0.05),
  ];

  /// 温度单位（特殊处理，不使用 toBaseRatio）
  static const temperatureUnits = [
    ConversionUnit(id: 'celsius', name: '摄氏度', symbol: '°C', toBaseRatio: 1.0),
    ConversionUnit(
      id: 'fahrenheit',
      name: '华氏度',
      symbol: '°F',
      toBaseRatio: 1.0,
    ),
    ConversionUnit(id: 'kelvin', name: '开尔文', symbol: 'K', toBaseRatio: 1.0),
  ];

  /// 体积单位
  static const volumeUnits = [
    ConversionUnit(
      id: 'cubic_meter',
      name: '立方米',
      symbol: 'm³',
      toBaseRatio: 1.0,
    ),
    ConversionUnit(id: 'liter', name: '升', symbol: 'L', toBaseRatio: 0.001),
    ConversionUnit(
      id: 'milliliter',
      name: '毫升',
      symbol: 'mL',
      toBaseRatio: 0.000001,
    ),
    ConversionUnit(
      id: 'cubic_centimeter',
      name: '立方厘米',
      symbol: 'cm³',
      toBaseRatio: 0.000001,
    ),
    ConversionUnit(
      id: 'gallon',
      name: '加仑',
      symbol: 'gal',
      toBaseRatio: 0.00378541,
    ),
    ConversionUnit(
      id: 'pint',
      name: '品脱',
      symbol: 'pt',
      toBaseRatio: 0.000473176,
    ),
    ConversionUnit(
      id: 'cubic_foot',
      name: '立方英尺',
      symbol: 'ft³',
      toBaseRatio: 0.0283168,
    ),
  ];

  /// 速度单位
  static const speedUnits = [
    ConversionUnit(
      id: 'meter_per_second',
      name: '米/秒',
      symbol: 'm/s',
      toBaseRatio: 1.0,
    ),
    ConversionUnit(
      id: 'kilometer_per_hour',
      name: '千米/时',
      symbol: 'km/h',
      toBaseRatio: 0.277778,
    ),
    ConversionUnit(
      id: 'mile_per_hour',
      name: '英里/时',
      symbol: 'mph',
      toBaseRatio: 0.44704,
    ),
    ConversionUnit(id: 'knot', name: '节', symbol: 'kn', toBaseRatio: 0.514444),
    ConversionUnit(
      id: 'foot_per_second',
      name: '英尺/秒',
      symbol: 'ft/s',
      toBaseRatio: 0.3048,
    ),
  ];

  /// 压强单位
  static const pressureUnits = [
    ConversionUnit(id: 'pascal', name: '帕斯卡', symbol: 'Pa', toBaseRatio: 1.0),
    ConversionUnit(
      id: 'kilopascal',
      name: '千帕',
      symbol: 'kPa',
      toBaseRatio: 1000.0,
    ),
    ConversionUnit(
      id: 'megapascal',
      name: '兆帕',
      symbol: 'MPa',
      toBaseRatio: 1000000.0,
    ),
    ConversionUnit(id: 'bar', name: '巴', symbol: 'bar', toBaseRatio: 100000.0),
    ConversionUnit(
      id: 'atmosphere',
      name: '大气压',
      symbol: 'atm',
      toBaseRatio: 101325.0,
    ),
    ConversionUnit(
      id: 'mmhg',
      name: '毫米汞柱',
      symbol: 'mmHg',
      toBaseRatio: 133.322,
    ),
    ConversionUnit(
      id: 'psi',
      name: '磅/平方英寸',
      symbol: 'psi',
      toBaseRatio: 6894.76,
    ),
  ];

  /// 功率单位
  static const powerUnits = [
    ConversionUnit(id: 'watt', name: '瓦特', symbol: 'W', toBaseRatio: 1.0),
    ConversionUnit(
      id: 'kilowatt',
      name: '千瓦',
      symbol: 'kW',
      toBaseRatio: 1000.0,
    ),
    ConversionUnit(
      id: 'megawatt',
      name: '兆瓦',
      symbol: 'MW',
      toBaseRatio: 1000000.0,
    ),
    ConversionUnit(
      id: 'horsepower',
      name: '马力',
      symbol: 'hp',
      toBaseRatio: 745.7,
    ),
    ConversionUnit(
      id: 'btu_per_hour',
      name: 'BTU/时',
      symbol: 'BTU/h',
      toBaseRatio: 0.293071,
    ),
  ];

  /// 进制单位（特殊处理）
  static const numberSystemUnits = [
    ConversionUnit(id: 'binary', name: '二进制', symbol: 'BIN', toBaseRatio: 2.0),
    ConversionUnit(id: 'octal', name: '八进制', symbol: 'OCT', toBaseRatio: 8.0),
    ConversionUnit(
      id: 'decimal',
      name: '十进制',
      symbol: 'DEC',
      toBaseRatio: 10.0,
    ),
    ConversionUnit(
      id: 'hexadecimal',
      name: '十六进制',
      symbol: 'HEX',
      toBaseRatio: 16.0,
    ),
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
    const ConversionCategory(
      id: 'volume',
      name: '体积',
      icon: Icons.view_in_ar,
      units: volumeUnits,
    ),
    const ConversionCategory(
      id: 'speed',
      name: '速度',
      icon: Icons.speed,
      units: speedUnits,
    ),
    const ConversionCategory(
      id: 'pressure',
      name: '压强',
      icon: Icons.compress,
      units: pressureUnits,
    ),
    const ConversionCategory(
      id: 'power',
      name: '功率',
      icon: Icons.bolt,
      units: powerUnits,
    ),
    const ConversionCategory(
      id: 'number_system',
      name: '进制',
      icon: Icons.calculate,
      units: numberSystemUnits,
      isSpecial: true,
    ),
  ];
}
