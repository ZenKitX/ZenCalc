# 测试

测试文件位于 `test/`：

| 文件 | 类型 | 覆盖内容 |
|------|------|---------|
| `calculator_view_test.dart` | Widget | 基础输入与等号、科学模式切换、RAD/DEG 角度模式、AC 清零 |
| `converter_test.dart` | 单元 | ConversionLogic：单位/温度/进制/格式化等 30+ 用例 |
| `conversion_data_test.dart` | 单元 | ConversionData 完整性：9 类别、单位非空、特殊标记等 |
| `widget_test.dart` | Widget | 冒烟测试：初始显示 `0` |
| `zen_settings_service_test.dart` | 单元 | ZenSettingsService 逻辑 |

## 运行测试

```bash
flutter test
```

## 注意事项

> ⚠️ Calculator widget 测试用 `pumpFrame`（固定两次 400ms pump）推进动画，不能用 `pumpAndSettle`（光标无限动画）。