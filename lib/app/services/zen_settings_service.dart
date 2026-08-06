import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing zen quote settings
class ZenSettingsService {
  static const String _zenQuotesEnabledKey = 'zen_quotes_enabled';
  static const String _zenQuotesLanguageKey = 'zen_quotes_language';
  static const String _zenQuotesFrequencyKey = 'zen_quotes_frequency';

  // Default values
  static const bool _defaultEnabled = true;
  static const String _defaultLanguage = 'zh'; // Chinese
  static const double _defaultFrequency = 0.3; // 30% probability

  // Cache values
  static bool? _cachedEnabled;
  static String? _cachedLanguage;
  static double? _cachedFrequency;

  /// Get whether zen quotes are enabled
  static Future<bool> getZenQuotesEnabled() async {
    if (_cachedEnabled != null) return _cachedEnabled!;

    final prefs = await SharedPreferences.getInstance();
    _cachedEnabled = prefs.getBool(_zenQuotesEnabledKey) ?? _defaultEnabled;
    return _cachedEnabled!;
  }

  /// Set whether zen quotes are enabled
  static Future<void> setZenQuotesEnabled(bool enabled) async {
    _cachedEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_zenQuotesEnabledKey, enabled);
  }

  /// Get zen quotes language
  /// Returns: 'zh' (Chinese), 'en' (English), or 'ja' (Japanese)
  static Future<String> getZenQuotesLanguage() async {
    if (_cachedLanguage != null) return _cachedLanguage!;

    final prefs = await SharedPreferences.getInstance();
    _cachedLanguage =
        prefs.getString(_zenQuotesLanguageKey) ?? _defaultLanguage;
    return _cachedLanguage!;
  }

  /// Set zen quotes language
  /// language: 'zh' (Chinese), 'en' (English), or 'ja' (Japanese)
  static Future<void> setZenQuotesLanguage(String language) async {
    if (!['zh', 'en', 'ja'].contains(language)) {
      throw ArgumentError('Invalid language: $language. Must be zh, en, or ja');
    }

    _cachedLanguage = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_zenQuotesLanguageKey, language);
  }

  /// Get zen quotes display frequency (probability)
  /// Returns: 0.0 to 1.0 (0% to 100%)
  static Future<double> getZenQuotesFrequency() async {
    if (_cachedFrequency != null) return _cachedFrequency!;

    final prefs = await SharedPreferences.getInstance();
    _cachedFrequency =
        prefs.getDouble(_zenQuotesFrequencyKey) ?? _defaultFrequency;
    return _cachedFrequency!;
  }

  /// Set zen quotes display frequency (probability)
  /// frequency: 0.0 to 1.0 (0% to 100%)
  static Future<void> setZenQuotesFrequency(double frequency) async {
    if (frequency < 0.0 || frequency > 1.0) {
      throw ArgumentError('Frequency must be between 0.0 and 1.0');
    }

    _cachedFrequency = frequency;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_zenQuotesFrequencyKey, frequency);
  }

  /// Clear all cached values (useful for testing)
  static void clearCache() {
    _cachedEnabled = null;
    _cachedLanguage = null;
    _cachedFrequency = null;
  }

  /// Reset all settings to defaults
  static Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_zenQuotesEnabledKey);
    await prefs.remove(_zenQuotesLanguageKey);
    await prefs.remove(_zenQuotesFrequencyKey);
    clearCache();
  }
}
