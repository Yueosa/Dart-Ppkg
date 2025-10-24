enum OutputMode {
  plain, // 单文本模式
  timeOnly, // 单时间模式
  chainOnly, // 单调用栈模式
  full, // 全显示模式
}

void LOutput([
  Object? first = '',
  Object? second = '',
  Object? third = '',
  Object? fourth = '',
  Object? fifth = '',
  int level = 1, // 调用层级
  OutputMode mode = OutputMode.full,
]) {
  final args = [
    first,
    second,
    third,
    fourth,
    fifth,
  ].where((e) => e != null && e.toString().isNotEmpty).join(' ');

  // --- 栈信息 ---
  final trace = StackTrace.current.toString().split('\n');

  // 获取调用栈
  final matches = trace.take(level + 1).skip(1).map((line) {
    final match = RegExp(r'#\d+\s+([^\s]+)').firstMatch(line);
    return match?.group(1) ?? 'Unknown';
  }).toList();

  // 拼接调用链
  final callChain = matches.join(' <- ');

  final now = DateTime.now().toIso8601String().split('T').last;

  // --- 子方法：颜色格式化 ---
  String colorize(String text, int colorCode) =>
      '\x1B[${colorCode}m$text\x1B[0m';

  // [] 与 <- 统一样式
  const bracketColor = 30;
  const arrowColor = 36;

  // 主体颜色循环：31m ~ 35m
  final colors = [31, 32, 33, 34, 35];
  int colorIndex = 0;
  int nextColor() => colors[(colorIndex++) % colors.length];

  // --- 构造带颜色的调用链 ---
  final timeStr = colorize(now, nextColor());
  final chainParts = callChain
      .split(' <- ')
      .map((part) => colorize(part, nextColor()))
      .toList();
  final coloredChain = chainParts.join(colorize(' <- ', arrowColor));

  // --- 输出 ---
  final formatted = switch (mode) {
    OutputMode.plain => args,
    OutputMode.timeOnly =>
      '${colorize('[', bracketColor)}$timeStr${colorize(']', bracketColor)}: $args',
    OutputMode.chainOnly =>
      '${colorize('[', bracketColor)}$coloredChain${colorize(']', bracketColor)}: $args',
    OutputMode.full =>
      '${colorize('[', bracketColor)}$timeStr${colorize(']', bracketColor)}'
          '${colorize('[', bracketColor)}$coloredChain${colorize(']', bracketColor)}: $args',
  };

  print(formatted);
}
