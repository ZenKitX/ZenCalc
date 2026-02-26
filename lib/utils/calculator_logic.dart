class CalculatorLogic {
  // 计算表达式
  static String calculate(String expression) {
    try {
      // 替换显示符号为计算符号
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      // % 保持不变，作为取模运算符
      
      // 移除空格
      expression = expression.replaceAll(' ', '');
      
      // 如果表达式为空或只有0，返回0
      if (expression.isEmpty || expression == '0') {
        return '0';
      }
      
      // 解析并计算表达式
      double result = _evaluateExpression(expression);
      
      // 格式化结果
      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }
  
  // 评估表达式
  static double _evaluateExpression(String expression) {
    // 处理负数
    if (expression.startsWith('-')) {
      expression = '0$expression';
    }
    
    // 先处理乘除和取模
    expression = _processMulDivMod(expression);
    
    // 再处理加减
    return _processAddSub(expression);
  }
  
  // 处理乘除和取模运算
  static String _processMulDivMod(String expression) {
    while (expression.contains('*') || expression.contains('/') || expression.contains('%')) {
      // 找到第一个乘除取模运算符
      int opIndex = -1;
      String operator = '';
      
      int mulIndex = expression.indexOf('*');
      int divIndex = expression.indexOf('/');
      int modIndex = expression.indexOf('%');
      
      // 找到最靠前的运算符
      List<int> indices = [mulIndex, divIndex, modIndex].where((i) => i != -1).toList();
      if (indices.isEmpty) break;
      
      opIndex = indices.reduce((a, b) => a < b ? a : b);
      operator = expression[opIndex];
      
      // 提取左操作数
      int leftStart = _findNumberStart(expression, opIndex - 1);
      String leftStr = expression.substring(leftStart, opIndex);
      double left = double.parse(leftStr);
      
      // 提取右操作数
      int rightEnd = _findNumberEnd(expression, opIndex + 1);
      String rightStr = expression.substring(opIndex + 1, rightEnd);
      double right = double.parse(rightStr);
      
      // 计算结果
      double result;
      if (operator == '*') {
        result = left * right;
      } else if (operator == '/') {
        if (right == 0) throw Exception('Division by zero');
        result = left / right;
      } else if (operator == '%') {
        if (right == 0) throw Exception('Modulo by zero');
        result = left % right;
      } else {
        throw Exception('Unknown operator');
      }
      
      // 替换表达式
      expression = expression.substring(0, leftStart) +
          result.toString() +
          expression.substring(rightEnd);
    }
    
    return expression;
  }
  
  // 处理加减运算
  static double _processAddSub(String expression) {
    double result = 0;
    int i = 0;
    
    while (i < expression.length) {
      // 找到下一个运算符
      int nextOp = _findNextOperator(expression, i);
      
      if (nextOp == -1) {
        // 没有更多运算符，处理最后一个数字
        String numStr = expression.substring(i);
        result += double.parse(numStr);
        break;
      }
      
      // 提取数字
      String numStr = expression.substring(i, nextOp);
      double num = double.parse(numStr);
      
      if (i == 0) {
        result = num;
      } else {
        // 获取前一个运算符
        String prevOp = expression[i - 1];
        if (prevOp == '+') {
          result += num;
        } else if (prevOp == '-') {
          result -= num;
        }
      }
      
      i = nextOp + 1;
    }
    
    return result;
  }
  
  // 找到数字的开始位置
  static int _findNumberStart(String expression, int from) {
    int start = from;
    while (start > 0) {
      String char = expression[start - 1];
      if (char == '+' || char == '-' || char == '*' || char == '/') {
        break;
      }
      start--;
    }
    return start;
  }
  
  // 找到数字的结束位置
  static int _findNumberEnd(String expression, int from) {
    int end = from;
    while (end < expression.length) {
      String char = expression[end];
      if (char == '+' || char == '-' || char == '*' || char == '/') {
        break;
      }
      end++;
    }
    return end;
  }
  
  // 找到下一个加减运算符
  static int _findNextOperator(String expression, int from) {
    for (int i = from; i < expression.length; i++) {
      if (expression[i] == '+' || expression[i] == '-') {
        return i;
      }
    }
    return -1;
  }
  
  // 格式化结果
  static String _formatResult(double result) {
    // 如果是整数，不显示小数点
    if (result == result.toInt()) {
      return result.toInt().toString();
    }
    
    // 保留最多8位小数
    String resultStr = result.toStringAsFixed(8);
    
    // 移除尾部的0
    resultStr = resultStr.replaceAll(RegExp(r'0+$'), '');
    resultStr = resultStr.replaceAll(RegExp(r'\.$'), '');
    
    return resultStr;
  }
  
  // 验证输入是否有效
  static bool isValidInput(String current, String newChar) {
    // 空字符串，任何数字都可以
    if (current.isEmpty || current == '0') {
      return true;
    }
    
    // 不能连续输入运算符（这个检查将在界面层处理，允许替换）
    // 这里只检查基本的有效性
    
    // 小数点验证
    if (newChar == '.') {
      // 获取当前数字
      String currentNumber = _getCurrentNumber(current);
      // 如果当前数字已经有小数点，不能再添加
      if (currentNumber.contains('.')) {
        return false;
      }
      // 如果最后一个字符是运算符，需要先添加0
      if (current.isNotEmpty && _isOperator(current[current.length - 1])) {
        return false;
      }
    }
    
    return true;
  }
  
  // 判断是否是运算符
  static bool _isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '÷' || char == '%';
  }
  
  // 获取当前正在输入的数字
  static String _getCurrentNumber(String expression) {
    int i = expression.length - 1;
    while (i >= 0 && !_isOperator(expression[i])) {
      i--;
    }
    return expression.substring(i + 1);
  }
}
