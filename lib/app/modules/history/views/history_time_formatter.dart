/// 历史记录时间的展示层格式化
///
/// 职责：将时间戳转为人类可读的相对时间文案（中文）。
/// 属于展示逻辑，不放在数据模型中。
library;

/// 格式化历史记录时间为相对时间文案
String formatHistoryTime(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  if (difference.inMinutes < 1) {
    return '刚刚';
  } else if (difference.inHours < 1) {
    return '${difference.inMinutes}分钟前';
  } else if (difference.inDays < 1) {
    return '${difference.inHours}小时前';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}天前';
  } else {
    return '${timestamp.month}月${timestamp.day}日';
  }
}
