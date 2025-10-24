# LOutput 函数文档

#### 概述

`LOutput` 是一个增强的 Dart 日志输出函数，支持多种输出模式和彩色显示，便于调试和日志分析。

---

## 参数说明

#### 基础参数

-   `first` 到 `fifth`: 可选的输出内容参数（最多 5 个）

-   `level`: 调用栈层级深度（默认 1 层）

-   `mode`: 输出模式枚举

#### 输出模式(OutputMode)

-   `OutputMode.plain`: 仅输出原始文本

-   `OutputMode.timeOnly`: 显示时间 + 文本

-   `OutputMode.chainOnly`: 显示调用链 + 文本

-   `OutputMode.full`: 显示时间 + 调用链 + 文本（默认）

---

## 功能特性

#### 🎨 彩色输出

-   **时间戳**: 彩色显示

-   **调用链**: 每个方法名使用不同颜色

-   **箭头符号**: 固定青色显示

-   **括号**: 灰色显示

#### 🔗 调用链追踪

自动构建方法调用关系，格式：`方法 A <- 方法 B <- 方法 C`

#### ⏰ 时间显示

显示当前时间的 `ISO8601` 格式（精确到秒）

---

## 使用示例

```dart
import 'LOutput.dart';

void main() {
  LOutput('Hello World'); // 默认全显示模式

  LOutput('Error occurred', level: 2, mode: OutputMode.chainOnly);

  LOutput('Data loaded', mode: OutputMode.timeOnly);

  processData();
}

void processData() {
  [0, 1, 2, 3].where((num) => (num >= 2)).forEach((num) {
    LOutput(num, level: 4); // 显示4层调用栈
  });
}

```

## 输出

![Output](./Output.png)

---
