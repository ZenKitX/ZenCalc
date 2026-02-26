import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/neumorphic_button.dart';
import '../widgets/neumorphic_display.dart';
import '../utils/calculator_logic.dart';

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
    });
  }

  bool _isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '÷' || char == '%';
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
      body: Center(
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
                  // 顶部 - 极简设计，只保留主题切换
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: widget.onThemeToggle,
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
      ),
    );
  }
}
