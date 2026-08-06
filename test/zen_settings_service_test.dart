import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zen_calc/app/services/zen_settings_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    ZenSettingsService.clearCache();
  });

  group('ZenSettingsService - 禅语设置服务', () {
    test('默认值 - 禅语开启', () async {
      expect(await ZenSettingsService.getZenQuotesEnabled(), isTrue);
    });

    test('默认值 - 语言为中文', () async {
      expect(await ZenSettingsService.getZenQuotesLanguage(), 'zh');
    });

    test('默认值 - 频率为 0.3', () async {
      expect(await ZenSettingsService.getZenQuotesFrequency(), 0.3);
    });

    test('设置并读取 - 禅语开关', () async {
      await ZenSettingsService.setZenQuotesEnabled(false);
      expect(await ZenSettingsService.getZenQuotesEnabled(), isFalse);

      await ZenSettingsService.setZenQuotesEnabled(true);
      expect(await ZenSettingsService.getZenQuotesEnabled(), isTrue);
    });

    test('设置并读取 - 语言', () async {
      await ZenSettingsService.setZenQuotesLanguage('en');
      expect(await ZenSettingsService.getZenQuotesLanguage(), 'en');

      await ZenSettingsService.setZenQuotesLanguage('ja');
      expect(await ZenSettingsService.getZenQuotesLanguage(), 'ja');
    });

    test('设置非法语言抛出 ArgumentError', () async {
      await expectLater(
        ZenSettingsService.setZenQuotesLanguage('fr'),
        throwsArgumentError,
      );
    });

    test('设置并读取 - 频率', () async {
      await ZenSettingsService.setZenQuotesFrequency(0.8);
      expect(await ZenSettingsService.getZenQuotesFrequency(), 0.8);
    });

    test('设置非法频率抛出 ArgumentError', () async {
      await expectLater(
        ZenSettingsService.setZenQuotesFrequency(1.5),
        throwsArgumentError,
      );
      await expectLater(
        ZenSettingsService.setZenQuotesFrequency(-0.1),
        throwsArgumentError,
      );
    });

    test('重置为默认值', () async {
      await ZenSettingsService.setZenQuotesEnabled(false);
      await ZenSettingsService.setZenQuotesLanguage('en');
      await ZenSettingsService.setZenQuotesFrequency(0.9);

      await ZenSettingsService.resetToDefaults();

      expect(await ZenSettingsService.getZenQuotesEnabled(), isTrue);
      expect(await ZenSettingsService.getZenQuotesLanguage(), 'zh');
      expect(await ZenSettingsService.getZenQuotesFrequency(), 0.3);
    });

    test('clearCache 后重新从存储读取', () async {
      await ZenSettingsService.setZenQuotesEnabled(false);
      ZenSettingsService.clearCache();

      // 从 mock storage 读取
      expect(await ZenSettingsService.getZenQuotesEnabled(), isFalse);
    });
  });
}
