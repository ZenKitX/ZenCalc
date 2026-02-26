import 'dart:math';

class ZenQuoteService {
  static final Random _random = Random();
  
  // 禅意语录集合
  static final List<ZenQuote> _quotes = [
    // 计算相关
    ZenQuote(
      text: '一即一切，一切即一',
      context: ZenContext.calculation,
      trigger: '1',
    ),
    ZenQuote(
      text: '空即是色，色即是空',
      context: ZenContext.zero,
      trigger: '0',
    ),
    ZenQuote(
      text: '万法归一，一归何处',
      context: ZenContext.equals,
    ),
    ZenQuote(
      text: '加法是聚，减法是散，聚散皆自然',
      context: ZenContext.calculation,
    ),
    
    // 清除相关
    ZenQuote(
      text: '放下执念，心自清明',
      context: ZenContext.clear,
    ),
    ZenQuote(
      text: '归零，是为了更好的开始',
      context: ZenContext.clear,
    ),
    ZenQuote(
      text: '清空过去，活在当下',
      context: ZenContext.clear,
    ),
    
    // 错误相关
    ZenQuote(
      text: '错误亦是修行',
      context: ZenContext.error,
    ),
    ZenQuote(
      text: '无常即是常',
      context: ZenContext.error,
    ),
    
    // 通用禅语
    ZenQuote(
      text: '心静自然凉',
      context: ZenContext.general,
    ),
    ZenQuote(
      text: '行住坐卧，皆是修行',
      context: ZenContext.general,
    ),
    ZenQuote(
      text: '一花一世界，一叶一菩提',
      context: ZenContext.general,
    ),
    ZenQuote(
      text: '念起即觉，觉即不随',
      context: ZenContext.general,
    ),
    ZenQuote(
      text: '本来无一物，何处惹尘埃',
      context: ZenContext.general,
    ),
    ZenQuote(
      text: '平常心是道',
      context: ZenContext.general,
    ),
    ZenQuote(
      text: '行亦禅，坐亦禅',
      context: ZenContext.general,
    ),
    ZenQuote(
      text: '静而后能安，安而后能虑',
      context: ZenContext.general,
    ),
    ZenQuote(
      text: '万物静观皆自得',
      context: ZenContext.general,
    ),
    ZenQuote(
      text: '心无挂碍，无挂碍故',
      context: ZenContext.general,
    ),
    
    // 数字相关
    ZenQuote(
      text: '三生万物',
      context: ZenContext.calculation,
      trigger: '3',
    ),
    ZenQuote(
      text: '四季轮回，周而复始',
      context: ZenContext.calculation,
      trigger: '4',
    ),
    ZenQuote(
      text: '五蕴皆空',
      context: ZenContext.calculation,
      trigger: '5',
    ),
    ZenQuote(
      text: '六根清净',
      context: ZenContext.calculation,
      trigger: '6',
    ),
    ZenQuote(
      text: '七宝庄严',
      context: ZenContext.calculation,
      trigger: '7',
    ),
    ZenQuote(
      text: '八正道',
      context: ZenContext.calculation,
      trigger: '8',
    ),
    ZenQuote(
      text: '九九归一',
      context: ZenContext.calculation,
      trigger: '9',
    ),
    
    // 特殊结果
    ZenQuote(
      text: '圆满即是完美',
      context: ZenContext.equals,
      trigger: '100',
    ),
    ZenQuote(
      text: '千里之行，始于足下',
      context: ZenContext.equals,
      trigger: '1000',
    ),
  ];
  
  // 根据上下文获取禅语
  static ZenQuote? getQuote(ZenContext context, {String? trigger}) {
    // 如果有特定触发条件，优先匹配
    if (trigger != null) {
      final matchedQuotes = _quotes.where(
        (q) => q.context == context && q.trigger == trigger
      ).toList();
      
      if (matchedQuotes.isNotEmpty) {
        return matchedQuotes[_random.nextInt(matchedQuotes.length)];
      }
    }
    
    // 否则从该上下文中随机选择
    final contextQuotes = _quotes.where((q) => q.context == context).toList();
    
    if (contextQuotes.isEmpty) {
      // 如果没有匹配的上下文，返回通用禅语
      final generalQuotes = _quotes.where((q) => q.context == ZenContext.general).toList();
      return generalQuotes[_random.nextInt(generalQuotes.length)];
    }
    
    return contextQuotes[_random.nextInt(contextQuotes.length)];
  }
  
  // 随机获取一条禅语
  static ZenQuote getRandomQuote() {
    return _quotes[_random.nextInt(_quotes.length)];
  }
  
  // 检查是否应该显示禅语（概率控制）
  static bool shouldShowQuote({double probability = 0.3}) {
    return _random.nextDouble() < probability;
  }
}

// 禅语模型
class ZenQuote {
  final String text;
  final ZenContext context;
  final String? trigger; // 特定触发条件（如特定数字或结果）
  
  const ZenQuote({
    required this.text,
    required this.context,
    this.trigger,
  });
}

// 禅语上下文
enum ZenContext {
  calculation,  // 计算过程中
  equals,       // 按下等号
  clear,        // 清除操作
  error,        // 错误发生
  zero,         // 零相关
  general,      // 通用
}
