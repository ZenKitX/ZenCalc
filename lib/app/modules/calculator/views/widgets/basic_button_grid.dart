import 'package:flutter/material.dart';
import 'package:zen_calc/app/components/zen_calc_button.dart';

class BasicButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;
  final VoidCallback onClear;
  final VoidCallback onDelete;
  final VoidCallback onEquals;

  const BasicButtonGrid({
    super.key,
    required this.onButtonPressed,
    required this.onClear,
    required this.onDelete,
    required this.onEquals,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('basic'),
      children: [
        // 第一行：AC, %, ⌫, ÷
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: 'AC',
                    onTap: onClear,
                    isOperator: true,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: '%',
                    onTap: () => onButtonPressed('%'),
                    isOperator: true,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: '⌫',
                    onTap: onDelete,
                    isOperator: true,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
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
                  child: ZenCalcButton(
                    text: '7',
                    onTap: () => onButtonPressed('7'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: '8',
                    onTap: () => onButtonPressed('8'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: '9',
                    onTap: () => onButtonPressed('9'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
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
                  child: ZenCalcButton(
                    text: '4',
                    onTap: () => onButtonPressed('4'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: '5',
                    onTap: () => onButtonPressed('5'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: '6',
                    onTap: () => onButtonPressed('6'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
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
                  child: ZenCalcButton(
                    text: '1',
                    onTap: () => onButtonPressed('1'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: '2',
                    onTap: () => onButtonPressed('2'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: '3',
                    onTap: () => onButtonPressed('3'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
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
                  child: ZenCalcButton(
                    text: '00',
                    onTap: () => onButtonPressed('00'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: '0',
                    onTap: () => onButtonPressed('0'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
                    text: '.',
                    onTap: () => onButtonPressed('.'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ZenCalcButton(
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
    );
  }
}
