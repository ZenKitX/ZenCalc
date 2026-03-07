import 'package:flutter/material.dart';
import 'package:zen_calc/app/config/theme/app_theme.dart';
import 'package:zen_calc/app/components/zen_calc_display.dart';
import 'package:arithmetic_kit/arithmetic_kit.dart';
import 'package:feedback_kit/feedback_kit.dart';
import 'package:zen_calc/app/services/calculation_history_service.dart';
import 'package:zen_calc/app/services/zen_settings_service.dart';
import 'package:zen_quote_kit/zen_quote_kit.dart';
import 'package:zen_calc/app/modules/history/views/history_view.dart';
import 'package:zen_calc/app/modules/calculator/views/widgets/calculator_top_bar.dart';
import 'package:zen_calc/app/modules/calculator/views/widgets/basic_button_grid.dart';
import 'package:zen_calc/app/modules/calculator/views/widgets/scientific_button_grid.dart';
import 'package:zen_calc/app/modules/converter/views/converter_view.dart';

class CalculatorScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  
  const CalculatorScreen({
    super.key,
    required this.onThemeToggle,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  String result = '0';
  bool shouldResetDisplay = false;
  ZenQuote? _currentQuote;
  bool _showZenQuotes = true; // Will be loaded from settings
  String _zenQuotesLanguage = 'zh'; // Will be loaded from settings
  bool _isScientificMode = false; // 科学计算器模式
  bool _isInverseMode = false; // 反函数模式
  String _lastExpression = ''; // 保存上次的计算式
  late ZenQuoteService _zenQuoteService; // ZenQuoteKit service instance
  
  @override
  void initState() {
    super.initState();
    // Initialize zen quote service with default language
    _zenQuoteService = ZenQuoteService(language: _zenQuotesLanguage);
    // 加载历史记录
    CalculationHistoryService.loadFromLocal();
    // 加载禅语设置
    _loadZenSettings();
  }
  
  /// Load zen quote settings from SharedPreferences
  Future<void> _loadZenSettings() async {
    final enabled = await ZenSettingsService.getZenQuotesEnabled();
    final language = await ZenSettingsService.getZenQuotesLanguage();
    
    setState(() {
      _showZenQuotes = enabled;
      _zenQuotesLanguage = language;
      // Recreate service with new language
      _zenQuoteService = ZenQuoteService(language: language);
    });
  }
  
  /// Update zen quote language and recreate service
  void _updateZenQuoteLanguage(String language) {
    setState(() {
      _zenQuotesLanguage = language;
      _zenQuoteService = ZenQuoteService(language: language);
    });
  }

  void onButtonPressed(String value) {
    setState(() {
      // 如果上次按了等号，重置显示
      if (shouldResetDisplay) {
        if (_isOperator(value)) {
          // 如果是运算符，继续使用结果
          displayText = result + value;
        } else {
          // 如果是数字，重新开始
          displayText = value;
        }
        shouldResetDisplay = false;
        result = '0';
        _updatePreview();
        return;
      }

      // 处理初始状态
      if (displayText == '0') {
        if (value == '.') {
          displayText = '0.';
        } else if (value == '00') {
          displayText = '0';
        } else if (!_isOperator(value)) {
          displayText = value;
        } else {
          displayText = '0$value';
        }
        _updatePreview();
        return;
      }

      // 处理 00 按钮
      if (value == '00') {
        // 如果最后一个字符是运算符，不添加 00
        if (displayText.isNotEmpty && _isOperator(displayText[displayText.length - 1])) {
          return;
        }
        displayText += '00';
        _updatePreview();
        return;
      }

      // 处理运算符替换
      if (_isOperator(value)) {
        // 如果最后一个字符也是运算符，替换它
        if (displayText.isNotEmpty && _isOperator(displayText[displayText.length - 1])) {
          displayText = displayText.substring(0, displayText.length - 1) + value;
          _updatePreview();
          return;
        }
      }

      // 验证输入
      if (!BasicCalculator.isValidInput(displayText, value)) {
        return;
      }

      // 添加输入
      displayText += value;
      
      // 实时预览计算结果
      _updatePreview();
    });
  }

  // 实时预览计算结果
  void _updatePreview() {
    String expression = displayText;
    
    // 如果表达式为空或只有一个数字，不显示预览
    if (expression.isEmpty || expression == '0') {
      result = '0';
      return;
    }
    
    // 如果表达式以运算符结尾，移除它再计算
    if (expression.isNotEmpty && _isOperator(expression[expression.length - 1])) {
      expression = expression.substring(0, expression.length - 1);
    }
    
    // 如果移除运算符后为空，不显示预览
    if (expression.isEmpty) {
      result = '0';
      return;
    }
    
    // 计算预览结果
    String previewResult = _isScientificMode 
        ? ScientificCalculator.calculate(expression)
        : BasicCalculator.calculate(expression);
    
    // 只有当结果不是错误且与输入不同时才显示预览
    if (previewResult != 'Error' && previewResult != expression) {
      result = previewResult;
    } else {
      result = '0';
    }
  }

  void onClear() {
    setState(() {
      displayText = '0';
      result = '0';
      shouldResetDisplay = false;
      
      // 显示清除相关的禅语
      if (_showZenQuotes && _zenQuoteService.shouldShowQuote(probability: 0.5)) {
        _currentQuote = _zenQuoteService.getQuote(ZenContext.clear);
      }
    });
  }

  void onDelete() {
    setState(() {
      if (displayText.length > 1) {
        displayText = displayText.substring(0, displayText.length - 1);
      } else {
        displayText = '0';
      }
    });
  }

  void onEquals() {
    setState(() {
      // 如果表达式以运算符结尾，移除它
      String expression = displayText;
      if (expression.isNotEmpty && _isOperator(expression[expression.length - 1])) {
        expression = expression.substring(0, expression.length - 1);
      }

      // 保存计算式
      _lastExpression = expression;

      // 根据模式选择计算逻辑
      String finalResult = _isScientificMode 
          ? ScientificCalculator.calculate(expression)
          : BasicCalculator.calculate(expression);
      
      result = finalResult;
      shouldResetDisplay = true;
      
      // 只在按等号时保存到历史记录
      if (finalResult != 'Error') {
        CalculationHistoryService.addHistory(expression, finalResult);
      }
      
      // 显示等号相关的禅语
      if (_showZenQuotes) {
        if (finalResult == 'Error') {
          // 错误时显示错误相关禅语
          if (_zenQuoteService.shouldShowQuote(probability: 0.6)) {
            _currentQuote = _zenQuoteService.getQuote(ZenContext.error);
          }
        } else {
          // 检查特殊结果
          if (finalResult == '0' && _zenQuoteService.shouldShowQuote(probability: 0.4)) {
            _currentQuote = _zenQuoteService.getQuote(ZenContext.zero);
          } else if ((finalResult == '100' || finalResult == '1000') && _zenQuoteService.shouldShowQuote(probability: 0.7)) {
            _currentQuote = _zenQuoteService.getQuote(ZenContext.equals, trigger: finalResult);
          } else if (_zenQuoteService.shouldShowQuote(probability: 0.3)) {
            _currentQuote = _zenQuoteService.getQuote(ZenContext.equals);
          }
        }
      }
    });
  }

  // deg 按钮：显示上次的计算式
  void onShowLastExpression() {
    setState(() {
      if (_lastExpression.isNotEmpty) {
        displayText = _lastExpression;
        result = '0';
        shouldResetDisplay = false;
        _updatePreview();
      }
    });
  }

  // inv 按钮：切换反函数模式
  void onToggleInverse() {
    setState(() {
      _isInverseMode = !_isInverseMode;
    });
  }

  bool _isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '÷' || char == '%';
  }

  // 构建科学计算器布局（使用独立组件）
  Widget _buildScientificCalculator() {
    return ScientificButtonGrid(
      onButtonPressed: onButtonPressed,
      onClear: onClear,
      onDelete: onDelete,
      onEquals: onEquals,
      isInverseMode: _isInverseMode,
      onToggleInverse: onToggleInverse,
      onShowLastExpression: onShowLastExpression,
    );
  }

  // 显示设置对话框
  void _showSettingsDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? AppTheme.darkShadowDark.withOpacity(0.6)
                          : AppTheme.lightShadowDark.withOpacity(0.4),
                      offset: const Offset(6, 6),
                      blurRadius: 12,
                    ),
                    BoxShadow(
                      color: isDark
                          ? AppTheme.darkShadowLight.withOpacity(0.6)
                          : AppTheme.lightShadowLight,
                      offset: const Offset(-6, -6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '禅意设置',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppTheme.darkText : AppTheme.lightText,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // 触觉反馈开关
                    _buildSettingRow(
                      context,
                      icon: Icons.vibration,
                      title: '触觉反馈',
                      subtitle: '按钮按下时的震动反馈',
                      value: HapticService.isEnabled,
                      onChanged: (value) {
                        setDialogState(() {
                          HapticService.setEnabled(value);
                          if (value) HapticService.light();
                        });
                      },
                      isDark: isDark,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 禅语开关
                    _buildSettingRow(
                      context,
                      icon: Icons.spa_outlined,
                      title: '禅意语录',
                      subtitle: '在特定时刻显示禅语',
                      value: _showZenQuotes,
                      onChanged: (value) async {
                        setDialogState(() {
                          _showZenQuotes = value;
                        });
                        // 保存到 SharedPreferences
                        await ZenSettingsService.setZenQuotesEnabled(value);
                        // 如果开启，立即显示一条禅语作为示例
                        if (value) {
                          setState(() {
                            _currentQuote = _zenQuoteService.getQuote(ZenContext.general);
                          });
                        }
                      },
                      isDark: isDark,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 语言选择
                    _buildLanguageSelector(
                      context,
                      isDark: isDark,
                      currentLanguage: _zenQuotesLanguage,
                      onLanguageChanged: (language) async {
                        // 保存到 SharedPreferences
                        await ZenSettingsService.setZenQuotesLanguage(language);
                        // Update language and recreate service
                        _updateZenQuoteLanguage(language);
                        setDialogState(() {
                          _zenQuotesLanguage = language;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 音效开关
                    _buildSettingRow(
                      context,
                      icon: Icons.music_note_outlined,
                      title: '禅意音效',
                      subtitle: '竹子、水滴等自然音效',
                      value: AudioService.isEnabled,
                      onChanged: (value) {
                        setDialogState(() {
                          AudioService.setEnabled(value);
                        });
                      },
                      isDark: isDark,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // 关闭按钮
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          HapticService.selection();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '完成',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? AppTheme.accentColorDark : AppTheme.accentColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context, {
    required bool isDark,
    required String currentLanguage,
    required Function(String) onLanguageChanged,
  }) {
    final languages = {
      'zh': '中文',
      'en': 'English',
      'ja': '日本語',
    };
    
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppTheme.darkShadowDark.withValues(alpha: 0.5)
                    : AppTheme.lightShadowDark.withValues(alpha: 0.3),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
              BoxShadow(
                color: isDark
                    ? AppTheme.darkShadowLight.withValues(alpha: 0.5)
                    : AppTheme.lightShadowLight,
                offset: const Offset(-2, -2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Icon(
            Icons.language,
            color: isDark ? AppTheme.darkText : AppTheme.lightText,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '禅语语言',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppTheme.darkText : AppTheme.lightText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '选择禅语显示的语言',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
        DropdownButton<String>(
          value: currentLanguage,
          dropdownColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
          style: TextStyle(
            color: isDark ? AppTheme.darkText : AppTheme.lightText,
            fontSize: 14,
          ),
          underline: Container(),
          items: languages.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onLanguageChanged(value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildSettingRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppTheme.darkShadowDark.withOpacity(0.5)
                    : AppTheme.lightShadowDark.withOpacity(0.3),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
              BoxShadow(
                color: isDark
                    ? AppTheme.darkShadowLight.withOpacity(0.5)
                    : AppTheme.lightShadowLight,
                offset: const Offset(-2, -2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: isDark ? AppTheme.darkText : AppTheme.lightText,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppTheme.darkText : AppTheme.lightText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: isDark ? AppTheme.accentColorDark : AppTheme.accentColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // 根据屏幕大小调整布局
    final isSmallScreen = screenHeight < 600;
    final maxWidth = screenWidth > 500 ? 500.0 : screenWidth;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: Stack(
        children: [
          // 主界面
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 16.0 : 24.0,
                    vertical: isSmallScreen ? 8.0 : 16.0,
                  ),
                  child: Column(
                    children: [
                      // 顶部工具栏
                      CalculatorTopBar(
                        isScientificMode: _isScientificMode,
                        onScientificToggle: () {
                          setState(() {
                            _isScientificMode = !_isScientificMode;
                          });
                        },
                        onSettingsTap: () => _showSettingsDialog(context),
                        onHistoryTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryScreen(
                                onSelectHistory: (value) {
                                  setState(() {
                                    displayText = value;
                                    result = value;
                                    shouldResetDisplay = true;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        onConverterTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConverterView(),
                            ),
                          );
                        },
                        onThemeToggle: widget.onThemeToggle,
                        isDark: isDark,
                      ),
                      
                      SizedBox(height: isSmallScreen ? 16 : 24),
                      
                      // 显示区域 - 占据更多空间
                      Expanded(
                        flex: 3,
                        child: ZenCalcDisplay(
                          displayText: displayText,
                          result: result,
                          showResult: shouldResetDisplay,
                        ),
                      ),
                  
                      SizedBox(height: isSmallScreen ? 16 : 24),
                      
                      // 按钮区域 - 根据模式切换
                      Expanded(
                        flex: _isScientificMode ? 6 : 5,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return SizeTransition(
                              sizeFactor: animation,
                              axisAlignment: -1.0, // 从顶部开始展开
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                            return Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                ...previousChildren,
                                if (currentChild != null) currentChild,
                              ],
                            );
                          },
                          child: _isScientificMode
                              ? _buildScientificCalculator()
                              : BasicButtonGrid(
                                  onButtonPressed: onButtonPressed,
                                  onClear: onClear,
                                  onDelete: onDelete,
                                  onEquals: onEquals,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        
        // 禅语浮层 - 使用 ZenQuoteKit 的 ZenQuoteWidget
        if (_currentQuote != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: ZenQuoteWidget(
                quote: _currentQuote!,
                onDismiss: () {
                  setState(() {
                    _currentQuote = null;
                  });
                },
              ),
            ),
          ),
        ],  // Stack children 结束
      ),  // Stack 结束 (body)
    );  // Scaffold 结束
  }
}