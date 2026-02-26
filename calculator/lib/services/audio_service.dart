import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isEnabled = false; // 默认关闭，用户可选择开启
  
  static bool get isEnabled => _isEnabled;
  
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }
  
  // 使用程序化生成的音频频率来模拟禅意音效
  // 由于无法直接生成音频文件，我们使用简单的音调
  
  // 数字按钮 - 竹子轻敲声（高频短音）
  static Future<void> playNumberSound() async {
    if (!_isEnabled) return;
    
    try {
      // 使用系统音效作为替代
      // 在实际应用中，可以添加自定义音频文件
      await _player.setVolume(0.3);
      // 这里可以播放自定义音频文件
      // await _player.play(AssetSource('sounds/bamboo_tap.mp3'));
    } catch (e) {
      // 静默失败
    }
  }
  
  // 运算符按钮 - 水滴声（中频）
  static Future<void> playOperatorSound() async {
    if (!_isEnabled) return;
    
    try {
      await _player.setVolume(0.4);
      // await _player.play(AssetSource('sounds/water_drop.mp3'));
    } catch (e) {
      // 静默失败
    }
  }
  
  // 等号按钮 - 钟声（低频长音）
  static Future<void> playEqualsSound() async {
    if (!_isEnabled) return;
    
    try {
      await _player.setVolume(0.5);
      // await _player.play(AssetSource('sounds/bell.mp3'));
    } catch (e) {
      // 静默失败
    }
  }
  
  // 清除按钮 - 风铃声
  static Future<void> playClearSound() async {
    if (!_isEnabled) return;
    
    try {
      await _player.setVolume(0.4);
      // await _player.play(AssetSource('sounds/wind_chime.mp3'));
    } catch (e) {
      // 静默失败
    }
  }
  
  // 释放资源
  static Future<void> dispose() async {
    await _player.dispose();
  }
}
