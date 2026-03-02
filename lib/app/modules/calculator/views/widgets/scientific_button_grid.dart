import 'package:flutter/material.dart';
import 'package:zen_calc/app/components/neumorphic_button.dart';

class ScientificButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;
  final VoidCallback onClear;
  final VoidCallback onDelete;
  final VoidCallback onEquals;

  const ScientificButtonGrid({
    super.key,
    required this.onButtonPressed,
    required this.onClear,
    required this.onDelete,
    required this.onEquals,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('scientific'),
      children: [
        // 第一行：sin, cos, tan, rad, deg
        Expanded(
          child: Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'sin', onTap: () => onButtonPressed('sin'), isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'cos', onTap: () => onButtonPressed('cos'), isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'tan', onTap: () => onButtonPressed('tan'), isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'rad', onTap: () {}, isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'deg', onTap: () {}, isOperator: true, fontSize: 14))),
            ],
          ),
        ),
        
        // 第二行：log, ln, (, ), inv
        Expanded(
          child: Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'log', onTap: () => onButtonPressed('log'), isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'ln', onTap: () => onButtonPressed('ln'), isOperator: true, fontSize: 14))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '(', onTap: () => onButtonPressed('('), isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: ')', onTap: () => onButtonPressed(')'), isOperator: true))),
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: 'inv', onTap: () {}, isOperator: true, fontSize: 14))),
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
        
        // 第五行：√, 4, 5, 6, -
        Expanded(
          child: Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.all(3.0), child: NeumorphicButton(text: '√', onTap: () => onButtonPressed('sqrt'), isOperator: true))),
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
