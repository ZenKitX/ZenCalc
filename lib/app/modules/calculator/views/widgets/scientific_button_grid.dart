import 'package:flutter/material.dart';
import 'package:zen_calc/app/components/neumorphic_button.dart';

class ScientificButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;
  final VoidCallback onClear;
  final VoidCallback onDelete;
  final VoidCallback onEquals;
  final bool isInverseMode;
  final VoidCallback onToggleInverse;
  final VoidCallback onShowLastExpression;

  const ScientificButtonGrid({
    super.key,
    required this.onButtonPressed,
    required this.onClear,
    required this.onDelete,
    required this.onEquals,
    required this.isInverseMode,
    required this.onToggleInverse,
    required this.onShowLastExpression,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('scientific'),
      children: [
        // 第一行：sin/sin⁻¹, cos/cos⁻¹, tan/tan⁻¹, rad, deg
        Expanded(
          child: Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: isInverseMode ? 'sin⁻¹' : 'sin', onTap: () => onButtonPressed(isInverseMode ? 'asin' : 'sin'), isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: isInverseMode ? 'cos⁻¹' : 'cos', onTap: () => onButtonPressed(isInverseMode ? 'acos' : 'cos'), isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: isInverseMode ? 'tan⁻¹' : 'tan', onTap: () => onButtonPressed(isInverseMode ? 'atan' : 'tan'), isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'rad', onTap: () {}, isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'deg', onTap: onShowLastExpression, isOperator: true, fontSize: 14))),
            ],
          ),
        ),
        
        // 第二行：log/10^, ln/e^, (, ), inv
        Expanded(
          child: Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: isInverseMode ? '10^' : 'log', onTap: () => onButtonPressed(isInverseMode ? '10^' : 'log'), isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: isInverseMode ? 'e^' : 'ln', onTap: () => onButtonPressed(isInverseMode ? 'e^' : 'ln'), isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '(', onTap: () => onButtonPressed('('), isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: ')', onTap: () => onButtonPressed(')'), isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'inv', onTap: onToggleInverse, isOperator: true, fontSize: 14, textColor: isInverseMode ? Colors.deepOrange : null))),
            ],
          ),
        ),
        
        // 第三行：!, AC, %, ⌫, ÷
        Expanded(
          child: Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '!', onTap: () => onButtonPressed('!'), isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'AC', onTap: onClear, isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '%', onTap: () => onButtonPressed('%'), isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '⌫', onTap: onDelete, isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '÷', onTap: () => onButtonPressed('÷'), isOperator: true))),
            ],
          ),
        ),
        
        // 第四行：^, 7, 8, 9, ×
        Expanded(
          child: Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '^', onTap: () => onButtonPressed('^'), isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '7', onTap: () => onButtonPressed('7')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '8', onTap: () => onButtonPressed('8')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '9', onTap: () => onButtonPressed('9')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '×', onTap: () => onButtonPressed('×'), isOperator: true))),
            ],
          ),
        ),
        
        // 第五行：√/x², 4, 5, 6, -
        Expanded(
          child: Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: isInverseMode ? 'x²' : '√', onTap: () => onButtonPressed(isInverseMode ? 'x²' : 'sqrt'), isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '4', onTap: () => onButtonPressed('4')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '5', onTap: () => onButtonPressed('5')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '6', onTap: () => onButtonPressed('6')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '-', onTap: () => onButtonPressed('-'), isOperator: true))),
            ],
          ),
        ),
        
        // 第六行：π, 1, 2, 3, +
        Expanded(
          child: Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'π', onTap: () => onButtonPressed('π'), isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '1', onTap: () => onButtonPressed('1')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '2', onTap: () => onButtonPressed('2')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '3', onTap: () => onButtonPressed('3')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '+', onTap: () => onButtonPressed('+'), isOperator: true))),
            ],
          ),
        ),
        
        // 第七行：e, 00, 0, ., =
        Expanded(
          child: Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'e', onTap: () => onButtonPressed('e'), isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '00', onTap: () => onButtonPressed('00')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '0', onTap: () => onButtonPressed('0')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '.', onTap: () => onButtonPressed('.')))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '=', onTap: onEquals, isEquals: true))),
            ],
          ),
        ),
      ],
    );
  }
}
