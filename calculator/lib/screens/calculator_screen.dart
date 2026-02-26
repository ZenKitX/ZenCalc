import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/neumorphic_button.dart';
import '../widgets/neumorphic_display.dart';
import '../widgets/zen_quote_widget.dart';
import '../utils/calculator_logic.dart';
import '../services/haptic_service.dart';
import '../services/audio_service.dart';
import '../services/zen_quote_service.dart';
import '../services/history_service.dart';
import 'history_screen.dart';

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
  bool _showZenQuotes = true; // 默认开启禅语
  
  @override
  void initState() {
    super.initState();
    // 加载历史记录
    HistoryService.loadFromLocal();
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
        return;
      }

      // 处理 00 按钮
      if (value == '00') {
        // 如果最后一个字符是运算符，不添加 00
        if (displayText.isNotEmpty && _isOperator(displayText[displayText.length - 1])) {
          return;
        }
        displayText += '00';
        return;
      }

      // 处理运算符替换
      if (_isOperator(value)) {
        // 如果最后一个字符也是运算符，替换它
        if (displayText.isNotEmpty && _isOperator(displayText[displayText.length - 1])) {
          displayText = displayText.substring(0, displayText.length - 1) + value;
          return;
        }
      }

      // 验证输入
      if (!CalculatorLogic.isValidInput(displayText, value)) {
        return;
      }

      // 添加输入
      displayText += value;
    });
  }

  void onClear() {
    setState(() {
      displayText = '0';
      result = '0';
      shouldResetDisplay = false;
      
      // 显示清除相关的禅语
      if (_showZenQuotes && ZenQuoteService.shouldShowQuote(probability: 0.5)) {
        _currentQuote = ZenQuoteService.getQuote(ZenContext.clear);
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

      // 计算结果
      result = CalculatorLogic.calculate(expression);
      shouldResetDisplay = true;
      
      // 保存到历史记录
      if (result != 'Error') {
        HistoryService.addHistory(expression, result);
      }
      
      // 显示等号相关的禅语
      if (_showZenQuotes) {
        if (result == 'Error') {
          // 错误时显示错误相关禅语
          if (ZenQuoteService.shouldShowQuote(probability: 0.6)) {
            _currentQuote = ZenQuoteService.getQuote(ZenContext.error);
          }
        } else {
          // 检查特殊结果
          if (result == '0' && ZenQuoteService.shouldShowQuote(probability: 0.4)) {
            _currentQuote = ZenQuoteService.getQuote(ZenContext.zero);
          } else if ((result == '100' || result == '1000') && ZenQuoteService.shouldShowQuote(probability: 0.7)) {
            _currentQuote = ZenQuoteService.getQuote(ZenContext.equals, trigger: result);
          } else if (ZenQuoteService.shouldShowQuote(probability: 0.3)) {
            _currentQuote = ZenQuoteService.getQuote(ZenContext.equals);
          }
        }
      }
    });
  }

  bool _isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '÷' || char == '%';
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
                      onChanged: (value) {
                        setDialogState(() {
                          _showZenQuotes = value;
                          // 如果开启，立即显示一条禅语作为示例
                          if (value) {
                            setState(() {
                              _currentQuote = ZenQuoteService.getQuote(ZenContext.general);
                            });
                          }
                        });
                      },
                      isDark: isDark,
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
                  // 顶部 - 极简设计，主题切换和设置
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 设置按钮
                      GestureDetector(
                        onTap: () {
                          HapticService.selection();
                          _showSettingsDialog(context);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? AppTheme.darkShadowDark.withOpacity(0.6)
                                    : AppTheme.lightShadowDark.withOpacity(0.4),
                                offset: const Offset(3, 3),
                                blurRadius: 6,
                              ),
                              BoxShadow(
                                color: isDark
                                    ? AppTheme.darkShadowLight.withOpacity(0.6)
                                    : AppTheme.lightShadowLight,
                                offset: const Offset(-3, -3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.tune_outlined,
                            color: isDark ? AppTheme.darkText : AppTheme.lightText,
                            size: 20,
                          ),
                        ),
                      ),
                      
                      Row(
                        children: [
                          // 历史记录按钮
                          GestureDetector(
                            onTap: () {
                              HapticService.selection();
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
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: isDark
                                        ? AppTheme.darkShadowDark.withOpacity(0.6)
                                        : AppTheme.lightShadowDark.withOpacity(0.4),
                                    offset: const Offset(3, 3),
                                    blurRadius: 6,
                                  ),
                                  BoxShadow(
                                    color: isDark
                                        ? AppTheme.darkShadowLight.withOpacity(0.6)
                                        : AppTheme.lightShadowLight,
                                    offset: const Offset(-3, -3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.history,
                                color: isDark ? AppTheme.darkText : AppTheme.lightText,
                                size: 20,
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // 主题切换按钮
                          GestureDetector(
                            onTap: () {
                              HapticService.selection();
                              widget.onThemeToggle();
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: isDark
                                        ? AppTheme.darkShadowDark.withOpacity(0.6)
                                        : AppTheme.lightShadowDark.withOpacity(0.4),
                                    offset: const Offset(3, 3),
                                    blurRadius: 6,
                                  ),
                                  BoxShadow(
                                    color: isDark
                                        ? AppTheme.darkShadowLight.withOpacity(0.6)
                                        : AppTheme.lightShadowLight,
                                    offset: const Offset(-3, -3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (Widget child, Animation<double> animation) {
                                  return RotationTransition(
                                    turns: animation,
                                    child: FadeTransition(opacity: animation, child: child),
                                  );
                                },
                                child: Icon(
                                  isDark ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
                                  key: ValueKey<bool>(isDark),
                                  color: isDark ? AppTheme.darkText : AppTheme.lightText,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: isSmallScreen ? 16 : 24),
                  
                  // 显示区域 - 占据更多空间
                  Expanded(
                    flex: 3,
                    child: NeumorphicDisplay(
                      displayText: displayText,
                      result: result,
                    ),
                  ),
              
              SizedBox(height: isSmallScreen ? 16 : 24),
              
              // 按钮区域 - 减小比例
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    // 第一行：AC, %, ⌫, ÷
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: 'AC',
                                onTap: onClear,
                                isOperator: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '%',
                                onTap: () => onButtonPressed('%'),
                                isOperator: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '⌫',
                                onTap: onDelete,
                                isOperator: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '÷',
                                onTap: () => onButtonPressed('÷'),
                                isOperator: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // 第二行：7, 8, 9, ×
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '7',
                                onTap: () => onButtonPressed('7'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '8',
                                onTap: () => onButtonPressed('8'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '9',
                                onTap: () => onButtonPressed('9'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '×',
                                onTap: () => onButtonPressed('×'),
                                isOperator: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // 第三行：4, 5, 6, -
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '4',
                                onTap: () => onButtonPressed('4'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '5',
                                onTap: () => onButtonPressed('5'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '6',
                                onTap: () => onButtonPressed('6'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '-',
                                onTap: () => onButtonPressed('-'),
                                isOperator: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // 第四行：1, 2, 3, +
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '1',
                                onTap: () => onButtonPressed('1'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '2',
                                onTap: () => onButtonPressed('2'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '3',
                                onTap: () => onButtonPressed('3'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '+',
                                onTap: () => onButtonPressed('+'),
                                isOperator: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // 第五行：00, 0, ., =
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '00',
                                onTap: () => onButtonPressed('00'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '0',
                                onTap: () => onButtonPressed('0'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '.',
                                onTap: () => onButtonPressed('.'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeumorphicButton(
                                text: '=',
                                onTap: onEquals,
                                isEquals: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                ],
              ),
            ),
          ),
        ),
          ),  // Center 结束
        
        // 禅语浮层
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