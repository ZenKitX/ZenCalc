import 'dart:math' as math;

class ScientificCalculatorLogic {
  // 计算科学表达式
  static String calculate(String expression) {
    try {
      // 替换显示符号为计算符号
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      
      // 移除空格
      expression = expression.replaceAll(' ', '');
      
      // 如果表达式为空或只有0，返回0
      if (expression.isEmpty || expression == '0') {
        return '0';
      }
      
      // 解析并计算表达式
      double result = _evaluateExpression(expression);
      
      // 检查结果是否有效
      if (result.isNaN || result.isInfinite) {
        return 'Error';
      }
      
      // 格式化结果
      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }
  
  // 评估表达式（简化版本）
  static double _evaluateExpression(String expression) {
    // 处理科学函数
    expression = _processScientificFunctions(expression);
    
    // 处理幂运算
    expression = _processPower(expression);
    
    // 使用基础计算逻辑处理剩余运算
    return _evaluateBasic(expression);
  }
  
  // 处理科学函数
  static String _processScientificFunctions(String expression) {
    // 先处理 e^ 和 10^，避免 e 被提前替换
    // 处理 10^ (10的幂)
    while (expression.contains('10^')) {
      int index = expression.indexOf('10^');
      int numStart = index + 3;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.pow(10, num).toDouble();
      expression = expression.replaceFirst('10^$numStr', result.toString());
    }
    
    // 处理 e^ (e的幂) - 必须在替换单独的 e 之前
    while (expression.contains('e^')) {
      int index = expression.indexOf('e^');
      int numStart = index + 2;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.exp(num);
      expression = expression.replaceFirst('e^$numStr', result.toString());
    }
    
    // 现在可以安全地替换 π 和 e 常数
    expression = expression.replaceAll('π', math.pi.toString());
    expression = expression.replaceAll('e', math.e.toString());
    
    // 处理 asin (反正弦)
    while (expression.contains('asin')) {
      int index = expression.indexOf('asin');
      int numStart = index + 4;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.asin(num);
      expression = expression.replaceFirst('asin$numStr', result.toString());
    }
    
    // 处理 acos (反余弦)
    while (expression.contains('acos')) {
      int index = expression.indexOf('acos');
      int numStart = index + 4;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.acos(num);
      expression = expression.replaceFirst('acos$numStr', result.toString());
    }
    
    // 处理 atan (反正切)
    while (expression.contains('atan')) {
      int index = expression.indexOf('atan');
      int numStart = index + 4;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.atan(num);
      expression = expression.replaceFirst('atan$numStr', result.toString());
    }
    
    // 处理 sqrt
    while (expression.contains('sqrt')) {
      int index = expression.indexOf('sqrt');
      int numStart = index + 4;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.sqrt(num);
      expression = expression.replaceFirst('sqrt$numStr', result.toString());
    }
    
    // 处理 x² (平方)
    while (expression.contains('x²')) {
      int index = expression.indexOf('x²');
      String numStr = _extractNumberBackward(expression, index - 1);
      double num = double.parse(numStr);
      double result = num * num;
      expression = expression.replaceFirst('${numStr}x²', result.toString());
    }
    
    // 处理 sin
    while (expression.contains('sin')) {
      int index = expression.indexOf('sin');
      int numStart = index + 3;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.sin(num);
      expression = expression.replaceFirst('sin$numStr', result.toString());
    }
    
    // 处理 cos
    while (expression.contains('cos')) {
      int index = expression.indexOf('cos');
      int numStart = index + 3;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.cos(num);
      expression = expression.replaceFirst('cos$numStr', result.toString());
    }
    
    // 处理 tan
    while (expression.contains('tan')) {
      int index = expression.indexOf('tan');
      int numStart = index + 3;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.tan(num);
      expression = expression.replaceFirst('tan$numStr', result.toString());
    }
    
    // 处理 log
    while (expression.contains('log')) {
      int index = expression.indexOf('log');
      int numStart = index + 3;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.log(num) / math.ln10;
      expression = expression.replaceFirst('log$numStr', result.toString());
    }
    
    // 处理 ln
    while (expression.contains('ln')) {
      int index = expression.indexOf('ln');
      int numStart = index + 2;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.log(num);
      expression = expression.replaceFirst('ln$numStr', result.toString());
    }
    
    return expression;
  }
  
  // 提取数字
  static String _extractNumber(String expression, int start) {
    StringBuffer num = StringBuffer();
    for (int i = start; i < expression.length; i++) {
      String char = expression[i];
      if (char == '.' || (char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57)) {
        num.write(char);
      } else {
        break;
      }
    }
    return num.toString();
  }
  
  // 处理幂运算
  static String _processPower(String expression) {
    while (expression.contains('^')) {
      int index = expression.indexOf('^');
      
      // 提取左操作数
      String leftStr = _extractNumberBackward(expression, index - 1);
      double left = double.parse(leftStr);
      
      // 提取右操作数
      String rightStr = _extractNumber(expression, index + 1);
      double right = double.parse(rightStr);
      
      // 计算结果
      double result = math.pow(left, right).toDouble();
      
      // 替换表达式
      expression = expression.replaceFirst('$leftStr^$rightStr', result.toString());
    }
    
    return expression;
  }
  
  // 向后提取数字
  static String _extractNumberBackward(String expression, int end) {
    StringBuffer num = StringBuffer();
    for (int i = end; i >= 0; i--) {
      String char = expression[i];
      if (char == '.' || (char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57)) {
        num.write(char);
      } else {
        break;
      }
    }
    return num.toString().split('').reversed.join();
  }
  
  // 基础计算（使用简单的eval逻辑）
  static double _evaluateBasic(String expression) {
    // 处理括号
    while (expression.contains('(')) {
      int closeIndex = expression.indexOf(')');
      int openIndex = expression.lastIndexOf('(', closeIndex);
      String subExpr = expression.substring(openIndex + 1, closeIndex);
      double subResult = _evaluateBasic(subExpr);
      expression = expression.substring(0, openIndex) +
          subResult.toString() +
          expression.substring(closeIndex + 1);
    }
    
    // 处理乘除
    expression = _processMulDiv(expression);
    
    // 处理加减
    return _processAddSub(expression);
  }
  
  // 处理乘除
  static String _processMulDiv(String expression) {
    while (expression.contains('*') || expression.contains('/')) {
      int mulIndex = expression.indexOf('*');
      int divIndex = expression.indexOf('/');
      
      int opIndex;
      String op;
      if (mulIndex == -1) {
        opIndex = divIndex;
        op = '/';
      } else if (divIndex == -1) {
        opIndex = mulIndex;
        op = '*';
      } else {
        if (mulIndex < divIndex) {
          opIndex = mulIndex;
          op = '*';
        } else {
          opIndex = divIndex;
          op = '/';
        }
      }
      
      String leftStr = _extractNumberBackward(expression, opIndex - 1);
      String rightStr = _extractNumber(expression, opIndex + 1);
      double left = double.parse(leftStr);
      double right = double.parse(rightStr);
      
      double result = op == '*' ? left * right : left / right;
      
      expression = expression.replaceFirst('$leftStr$op$rightStr', result.toString());
    }
    
    return expression;
  }
  
  // 处理加减
  static double _processAddSub(String expression) {
    List<String> parts = [];
    List<String> operators = [];
    
    StringBuffer currentNum = StringBuffer();
    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      if (char == '+' || char == '-') {
        if (currentNum.isNotEmpty) {
          parts.add(currentNum.toString());
          operators.add(char);
          currentNum.clear();
        } else if (char == '-') {
          currentNum.write(char);
        }
      } else {
        currentNum.write(char);
      }
    }
    if (currentNum.isNotEmpty) {
      parts.add(currentNum.toString());
    }
    
    if (parts.isEmpty) return 0;
    
    double result = double.parse(parts[0]);
    for (int i = 0; i < operators.length; i++) {
      if (operators[i] == '+') {
        result += double.parse(parts[i + 1]);
      } else {
        result -= double.parse(parts[i + 1]);
      }
    }
    
    return result;
  }
  
  // 格式化结果
  static String _formatResult(double result) {
    if (result == result.toInt() && result.abs() < 1e10) {
      return result.toInt().toString();
    }
    
    if (result.abs() >= 1e10 || (result.abs() < 1e-6 && result != 0)) {
      return result.toStringAsExponential(6);
    }
    
    String resultStr = result.toStringAsFixed(8);
    resultStr = resultStr.replaceAll(RegExp(r'0+$'), '');
    resultStr = resultStr.replaceAll(RegExp(r'\.$'), '');
    
    return resultStr;
  }
}
