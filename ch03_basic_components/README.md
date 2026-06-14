# 第3章：基础组件

基于《Flutter实战·第二版》第3章内容，覆盖 Flutter 六大基础组件类型。

## 章节知识图谱

```
基础组件 (ch03)
├── 3.1 文本及样式 ──── Text, RichText, TextStyle, TextSpan, DefaultTextStyle
├── 3.2 按钮 ────────── ElevatedButton, TextButton, OutlinedButton,
│                      IconButton, FloatingActionButton, SegmentedButton
├── 3.3 图片及ICON ──── Image.network, FadeInImage, BoxFit, Icon, colorBlendMode
├── 3.4 选择控件 ────── Switch, Checkbox(含三态), Radio, Slider, RangeSlider
├── 3.5 输入框及表单 ── TextField, TextFormField, Form, 校验, FocusNode, keyboardType
└── 3.6 进度指示器 ──── LinearProgressIndicator, CircularProgressIndicator
```

## 项目结构

```
ch03_basic_components/
├── lib/
│   ├── main.dart                          # 应用入口 + 底部导航
│   └── pages/
│       ├── text_page.dart                 # 3.1 文本及样式
│       ├── button_page.dart               # 3.2 按钮
│       ├── image_icon_page.dart           # 3.3 图片及ICON
│       ├── switch_checkbox_page.dart      # 3.4 单选开关和复选框
│       ├── form_page.dart                 # 3.5 输入框及表单
│       └── progress_page.dart             # 3.6 进度指示器
├── pubspec.yaml
└── README.md
```

## 核心知识点

### 3.1 文本及样式

| 组件/属性 | 说明 |
|-----------|------|
| `Text` | 最基础的文本显示组件 |
| `TextStyle` | 控制颜色、字号、粗细、斜体、装饰线、阴影等 |
| `textAlign` | 文本对齐方式: left, right, center, justify, start, end |
| `maxLines` | 最大行数，配合 `overflow: TextOverflow.ellipsis` 实现省略号 |
| `RichText + TextSpan` | 富文本，一个段落内多种样式混排 |
| `DefaultTextStyle` | 为子组件树提供默认文本样式（继承机制） |
| `textScaleFactor` | 文本缩放倍数 |

**关键代码 — RichText 富文本 (text_page.dart):**

```dart
RichText(
  text: TextSpan(
    style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
    children: const [
      TextSpan(text: '这是默认样式，'),
      TextSpan(text: '这是红色加粗',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      TextSpan(text: '这是蓝色大号',
        style: TextStyle(color: Colors.blue, fontSize: 22)),
    ],
  ),
)
```

### 3.2 按钮

| 组件 | 说明 | 常用构造 |
|------|------|---------|
| `ElevatedButton` | 凸起按钮（Material 3 填充按钮） | `.icon()` |
| `TextButton` | 文本按钮（无背景） | `.icon()` |
| `OutlinedButton` | 描边按钮 | `.icon()` |
| `IconButton` | 纯图标按钮 | `styleFrom()` |
| `FloatingActionButton` | 浮动操作按钮 | `.small()`, `.large()`, `.extended()` |
| `SegmentedButton` | Material 3 分段按钮 | 多段切换 |

按钮状态：`onPressed` 为 `null` 时进入禁用态。

**关键代码 — 自定义按钮样式 (button_page.dart):**

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  child: const Text('自定义样式'),
)
```

### 3.3 图片及ICON

| 组件/概念 | 说明 |
|-----------|------|
| `Image.network` | 网络图片 |
| `Image.asset` | 本地资源图片 |
| `Image.file` | 文件图片 |
| `FadeInImage` | 带占位图的淡入加载 |
| `BoxFit` | 图片适配模式（contain, cover, fill, fitWidth, fitHeight, none, scaleDown） |
| `colorBlendMode` | 颜色混合模式，实现图片着色效果 |
| `Icon` | Material Icons 图标库 |

**BoxFit 对比:**
- `contain`: 等比缩放完整显示，可能留白
- `cover`: 等比缩放填满，超出裁剪
- `fill`: 拉伸填满（可能变形）
- `fitWidth`: 宽度撑满

**关键代码 — BoxFit 效果对比网格 (image_icon_page.dart):**

```dart
GridView.count(
  crossAxisCount: 3,
  childAspectRatio: 1.3,
  children: BoxFit.values.map((fit) {
    return Column(children: [
      Expanded(child: Image.network(url, fit: fit)),
      Text(fit.name),
    ]);
  }).toList(),
)
```

### 3.4 单选开关和复选框

| 组件 | 选中值类型 | 常用场景 |
|------|-----------|----------|
| `Switch` | `bool` | 开关设置 |
| `SwitchListTile` | `bool` | 带标题的开关（设置页常用） |
| `Checkbox` | `bool` / `bool?` (三态) | 多选 |
| `CheckboxListTile` | `bool` | 带标题的复选框 |
| `Radio<T>` | `T` (groupValue) | 互斥单选 |
| `RadioListTile<T>` | `T` | 带标题的单选 |
| `Slider` | `double` | 数值滑块 |
| `RangeSlider` | `RangeValues` | 范围滑块 |

**三态复选框模式 (switch_checkbox_page.dart):**

```dart
CheckboxListTile(
  tristate: true,
  value: _checkboxTriState,  // null -> true -> false -> null 循环
  onChanged: ...
)
```

### 3.5 输入框及表单

| 概念 | 说明 |
|------|------|
| `TextField` | 基础输入框 |
| `TextEditingController` | 控制器，获取/设置输入文本 |
| `FocusNode` | 焦点节点，控制焦点获取和转移 |
| `TextFormField` | 表单输入框，支持 `validator` 校验 |
| `Form` | 表单容器，`GlobalKey<FormState>` 统一校验 |
| `keyboardType` | 键盘类型：text, number, emailAddress, phone 等 |
| `obscureText` | 密码输入（显示圆点掩码） |

**表单校验模式 (form_page.dart):**

```dart
final _formKey = GlobalKey<FormState>();
// 每个 TextFormField 的 validator 返回 null 通过、返回 String 显示错误
TextFormField(validator: (v) => v?.isEmpty == true ? '必填' : null)
// 提交
_formKey.currentState!.validate()
```

### 3.6 进度指示器

| 组件 | 说明 |
|------|------|
| `LinearProgressIndicator` | 线性进度条 |
| `CircularProgressIndicator` | 圆形进度指示器 |

两种模式：
- **determinate**: 传入 `value`（0.0~1.0），显示已知进度
- **indeterminate**: 不传 `value`，持续旋转动画

**自定义样式 (progress_page.dart):**

```dart
LinearProgressIndicator(
  value: 0.7,
  backgroundColor: Colors.grey,  // 轨道色
  color: Colors.green,           // 进度色  
  minHeight: 10,                 // 高度
)
```

## 运行方式

```bash
cd ch03_basic_components
flutter pub get
flutter run
```

## 关键 Flutter 概念

- **StatefulWidget vs StatelessWidget**: 需要动态更新状态的页面（Switch、Checkbox、Form）使用 `StatefulWidget`
- **setState()**: 调用后触发 widget rebuild
- **Controller 模式**: `TextEditingController` 持有输入状态，需在 `dispose()` 中释放
- **FocusNode**: 管理焦点链，配合 `textInputAction` 实现键盘"下一步"跳转
