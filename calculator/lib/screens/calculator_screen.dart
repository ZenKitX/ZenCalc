import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/neumorphic_button.dart';
import '../widgets/neumorphic_display.dart';
import '../utils/calculator_logic.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

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
        } else if (!_isOperator(value)) {
          displayText = value;
        } else {
          displayText = '0$value';
        }
        return;
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
    return char == '+' || char == '-' || char == '×' || char == '÷';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // 显示区域
              Expanded(
                flex: 2,
                child: NeumorphicDisplay(
                  displayText: displayText,
                  result: result,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // 按钮区域
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    // 第一行：C, ⌫, ÷
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: 'C',
                                onTap: onClear,
                                isOperator: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '⌫',
                                onTap: onDelete,
                                isOperator: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '7',
                                onTap: () => onButtonPressed('7'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '8',
                                onTap: () => onButtonPressed('8'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '9',
                                onTap: () => onButtonPressed('9'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '4',
                                onTap: () => onButtonPressed('4'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '5',
                                onTap: () => onButtonPressed('5'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '6',
                                onTap: () => onButtonPressed('6'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '1',
                                onTap: () => onButtonPressed('1'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '2',
                                onTap: () => onButtonPressed('2'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '3',
                                onTap: () => onButtonPressed('3'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                    
                    // 第五行：0, ., =
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '0',
                                onTap: () => onButtonPressed('0'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '.',
                                onTap: () => onButtonPressed('.'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeumorphicButton(
                                text: '=',
                                onTap: onEquals,
                                isOperator: true,
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
    );
  }
}
