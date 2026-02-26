import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class HapticService {
  static bool _isEnabled = true;
  
  static bool get isEnabled => _isEnabled;
  
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }
  
  // 轻柔的触觉反馈 - 用于数字按钮
  static Future<void> light() async {
    if (!_isEnabled) return;
    
    try {
      // 检查设备是否支持震动
      bool? hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator == true) {
        // 使用自定义震动模式：短暂轻柔
        await Vibration.vibrate(duration: 10, amplitude: 50);
      } else {
        // 降级到系统触觉反馈
        await HapticFeedback.lightImpact();
      }
    } catch (e) {
      // 如果出错，使用系统默认
      await HapticFeedback.lightImpact();
    }
  }
  
  // 中等触觉反馈 - 用于运算符按钮
  static Future<void> medium() async {
    if (!_isEnabled) return;
    
    try {
      bool? hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator == true) {
        await Vibration.vibrate(duration: 15, amplitude: 80);
      } else {
        await HapticFeedback.mediumImpact();
      }
    } catch (e) {
      await HapticFeedback.mediumImpact();
    }
  }
  
  // 强触觉反馈 - 用于等号和清除按钮
  static Future<void> heavy() async {
    if (!_isEnabled) return;
    
    try {
      bool? hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator == true) {
        await Vibration.vibrate(duration: 20, amplitude: 120);
      } else {
        await HapticFeedback.heavyImpact();
      }
    } catch (e) {
      await HapticFeedback.heavyImpact();
    }
  }
  
  // 选择反馈 - 用于主题切换
  static Future<void> selection() async {
    if (!_isEnabled) return;
    
    try {
      bool? hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator == true) {
        await Vibration.vibrate(duration: 8, amplitude: 40);
      } else {
        await HapticFeedback.selectionClick();
      }
    } catch (e) {
      await HapticFeedback.selectionClick();
    }
  }
}
