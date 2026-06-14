# Flutter实战·第二版 — 示例代码合集

基于 [《Flutter实战·第二版》](https://book.flutterchina.club)（作者：杜文 / wendux，机械工业出版社2023年出版）第3、4、5、8、11章的完整示例 Flutter 项目。

## 项目结构

```
flutter-.git/
├── ch03_basic_components/      # 第3章  基础组件
├── ch04_layout_components/     # 第4章  布局类组件
├── ch05_container_components/  # 第5章  容器类组件
├── ch08_event_handling/        # 第8章  事件处理与通知
├── ch11_file_network/          # 第11章 文件操作与网络请求
├── .gitignore
└── README.md
```

## 各章概览

### 第3章 — 基础组件

| 节 | 内容 | 涉及 Widget |
|----|------|------------|
| 3.1 | 文本及样式 | `Text`, `RichText`, `TextStyle`, `TextSpan`, `DefaultTextStyle` |
| 3.2 | 按钮 | `ElevatedButton`, `TextButton`, `OutlinedButton`, `IconButton`, `FAB`, `SegmentedButton` |
| 3.3 | 图片及ICON | `Image.network`, `FadeInImage`, `BoxFit`, `colorBlendMode`, `Icon` |
| 3.4 | 选择控件 | `Switch`, `Checkbox`(含三态), `Radio`, `Slider`, `RangeSlider` |
| 3.5 | 输入框及表单 | `TextField`, `TextFormField`, `Form`, `FocusNode`, `validator` |
| 3.6 | 进度指示器 | `LinearProgressIndicator`, `CircularProgressIndicator` |

### 第4章 — 布局类组件

| 节 | 内容 | 涉及 Widget |
|----|------|------------|
| 4.3 | 线性布局 | `Row`, `Column`, `mainAxisAlignment`, `crossAxisAlignment` |
| 4.4 | 弹性布局 | `Expanded`, `Flexible`, `Spacer`, `FlexFit.tight/loose` |
| 4.5 | 流式布局 | `Wrap`, `Flow` + 自定义 `FlowDelegate`(弧形排列) |
| 4.6 | 层叠布局 | `Stack`, `Positioned`, `IndexedStack`, 头像角标实战 |
| 4.7 | 对齐定位 | `Align`, `Center`, `Alignment(x,y)` 九宫格 |
| 4.8 | LayoutBuilder | 响应式布局, `ConstrainedBox`, `AspectRatio`, `FractionallySizedBox` |

### 第5章 — 容器类组件

| 节 | 内容 | 涉及 Widget |
|----|------|------------|
| 5.1 | 填充 | `Padding`, `EdgeInsets.all/symmetric/only/fromLTRB` |
| 5.2 | 装饰容器 | `DecoratedBox`, `BoxDecoration`, `LinearGradient`, `RadialGradient`, `SweepGradient` |
| 5.3 | 变换 | `Transform.rotate/scale/translate`, `RotatedBox`, `Matrix4`(3D) |
| 5.4 | 组合容器 | `Container`(margin→decoration→padding→child 层级可视化) |
| 5.5 | 剪裁 | `ClipRRect`, `ClipOval`, `ClipPath` + 自定义星形/三角形 `CustomClipper` |
| 5.6 | 空间适配 | `FittedBox`, `BoxFit` 全模式对比 |
| 5.7 | 页面骨架 | `Scaffold`, `AppBar`, `SnackBar`, `BottomSheet` |

### 第8章 — 事件处理与通知

| 节 | 内容 | 涉及 Widget / 模式 |
|----|------|-------------------|
| 8.1 | 原始指针事件 | `Listener`, `PointerEvent`, `AbsorbPointer`, `IgnorePointer`, 冒泡机制 |
| 8.2 | 手势识别 | `GestureDetector`, `onTap/DoubleTap/LongPress/Pan/Scale` |
| 8.4 | 手势竞争 | 手势竞技场 (GestureArena), 水平vs垂直拖拽竞争 |
| 8.5 | 事件总线 | `EventBus` (单例 + `StreamController.broadcast` + 购物车实战) |
| 8.6 | 通知 | `NotificationListener`, 自定义 `Notification`, `ScrollNotification` |

### 第11章 — 文件操作与网络请求

| 节 | 内容 | 涉及技术 |
|----|------|----------|
| 11.1 | 文件操作 | `File`, `Directory`, `readAsString/writeAsString`, `path_provider` |
| 11.2 | HttpClient | `dart:io` `HttpClient` |
| 11.3 | http 包 | `http.get/post`, JSON 请求/响应 |
| 11.5 | WebSocket | `web_socket_channel`, `IOWebSocketChannel`, 聊天消息界面 |
| 11.7 | JSON→Model | `fromJson` 工厂构造 / `toJson`, 三层嵌套解析 (User/Address/Geo) |

## 运行方式

每个子项目都可独立运行：

```bash
# 例如运行第3章
cd ch03_basic_components
flutter pub get
flutter run

# 运行第8章
cd ../ch08_event_handling
flutter pub get
flutter run
```

支持平台：Android / iOS / Web / Windows / macOS / Linux。

## Flutter 版本

开发基于 Flutter SDK 最新稳定版。如遇到兼容性问题，可运行：

```bash
flutter upgrade
flutter pub upgrade
```

## 参考资料

- [《Flutter实战·第二版》在线书稿](https://book.flutterchina.club)
- [Flutter 官方文档](https://docs.flutter.dev)
- [Dart 语言文档](https://dart.dev/guides)
