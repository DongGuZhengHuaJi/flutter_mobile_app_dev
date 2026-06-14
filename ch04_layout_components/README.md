# 第4章：布局类组件

基于《Flutter实战·第二版》第4章内容，系统演示 Flutter 布局体系。

## 章节知识图谱

```
布局类组件 (ch04)
├── 4.2 布局原理与约束 ── BoxConstraints, 约束传递机制
├── 4.3 线性布局 ──────── Row, Column, mainAxisAlignment, crossAxisAlignment
├── 4.4 弹性布局 ──────── Expanded, Flexible, Spacer, FlexFit
├── 4.5 流式布局 ──────── Wrap, Flow(自定义Delegate)
├── 4.6 层叠布局 ──────── Stack, Positioned, IndexedStack
├── 4.7 对齐与相对定位 ── Align, Center, Alignment
└── 4.8 LayoutBuilder ──── LayoutBuilder, ConstrainedBox, UnconstrainedBox,
                           AspectRatio, FractionallySizedBox, LimitedBox
```

## 项目结构

```
ch04_layout_components/
├── lib/
│   ├── main.dart                       # 应用入口 + 底部导航
│   └── pages/
│       ├── linear_layout_page.dart     # 4.3 线性布局
│       ├── flex_page.dart              # 4.4 弹性布局
│       ├── wrap_flow_page.dart         # 4.5 流式布局
│       ├── stack_page.dart             # 4.6 层叠布局
│       ├── align_page.dart             # 4.7 对齐与相对定位
│       └── layout_builder_page.dart    # 4.8 LayoutBuilder
├── pubspec.yaml
└── README.md
```

## 核心知识点

### 4.2 布局原理 — 约束传递

Flutter 布局的核心规则：**约束向下传递，尺寸向上传递，父节点设置子节点位置。**

- 父节点给子节点一个约束（最大/最小宽高）
- 子节点根据约束确定自己的尺寸
- 父节点根据子节点尺寸进行定位

### 4.3 线性布局 (Row / Column)

| 属性 | 说明 | 取值 |
|------|------|------|
| `mainAxisAlignment` | 主轴对齐 | start, end, center, spaceBetween, spaceAround, spaceEvenly |
| `crossAxisAlignment` | 交叉轴对齐 | start, end, center, stretch, baseline |
| `mainAxisSize` | 主轴尺寸 | max (占满), min (包裹) |
| `textDirection` | 文本方向 | ltr, rtl |
| `verticalDirection` | 垂直方向 | down, up |

**主轴 vs 交叉轴:**
- **Row**: 主轴=水平, 交叉轴=垂直
- **Column**: 主轴=垂直, 交叉轴=水平

**关键代码 (linear_layout_page.dart:23-53) — mainAxisAlignment 6种效果:**
```dart
Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [...])
// start | center | end | spaceBetween | spaceAround | spaceEvenly
```

**关键代码 (linear_layout_page.dart:58-87) — crossAxisAlignment 4种效果:**
```dart
Row(crossAxisAlignment: CrossAxisAlignment.start, children: [...])
// start | center | end | stretch
```

### 4.4 弹性布局 (Flex / Expanded / Flexible)

| 组件 | 说明 |
|------|------|
| `Expanded` | 强制填满剩余空间，可设 `flex` 比例 |
| `Flexible` | 弹性空间，`FlexFit.tight` = Expanded，`FlexFit.loose` = 不强制填满 |
| `Spacer` | 弹性空白，本质是 `Expanded` 的空容器 |

**关键代码 (flex_page.dart:17-34) — flex 比例分配:**
```dart
Row(
  children: [
    Expanded(flex: 2, child: Container(...)),  // 2/6
    Expanded(flex: 1, child: Container(...)),  // 1/6
    Expanded(flex: 3, child: Container(...)),  // 3/6
  ],
)
```

**Expanded vs Flexible:**
- `Expanded` = `Flexible(fit: FlexFit.tight)` — 强制填满
- `Flexible(fit: FlexFit.loose)` — 子元素可以小于可用空间

### 4.5 流式布局 (Wrap / Flow)

| 属性 | 说明 |
|------|------|
| `spacing` | 主轴方向间距 |
| `runSpacing` | 交叉轴方向间距（行间距） |
| `alignment` | 主轴对齐（WrapAlignment） |
| `runAlignment` | 交叉轴对齐 |
| `direction` | 排列方向（水平/垂直） |

**Wrap vs Flow:**
- **Wrap**: 内置换行逻辑，属性配置即可
- **Flow**: 需自定义 `FlowDelegate`，灵活度更高，但需要手动实现 `paintChildren` 和 `shouldRepaint`

**关键代码 (wrap_flow_page.dart:90-116) — 自定义 FlowDelegate 弧形排列:**
```dart
class _ArcFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      final angle = (i / (count - 1) - 0.5) * 1.2;
      final x = size.width / 2 + radius * sin(angle);
      final y = radius * (1 - cos(angle));
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }
}
```

### 4.6 层叠布局 (Stack / Positioned)

| 组件 | 说明 |
|------|------|
| `Stack` | 层叠容器，后加入的子元素在上层 |
| `Stack.alignment` | 未使用 Positioned 的子元素对齐方式 |
| `Positioned` | 绝对定位，可设 top/bottom/left/right/width/height |
| `IndexedStack` | 只显示 index 指定的子元素，其他子元素保留状态 |

**Positioned 定位规则:**
- 设置 `top` + `bottom` → 垂直拉伸
- 设置 `left` + `right` → 水平拉伸
- 只设其中一个 → 使用子元素自身尺寸

**实战模式 — 头像角标 (stack_page.dart:93-114):**
```dart
Stack(
  clipBehavior: Clip.none,
  children: [
    CircleAvatar(radius: 28, ...),
    Positioned(
      right: -2, bottom: -2,
      child: Container(  // 绿色在线点
        width: 16, height: 16,
        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
      ),
    ),
  ],
)
```

### 4.7 对齐与相对定位 (Align / Center)

| 组件 | 说明 |
|------|------|
| `Align` | 将子元素定位到父容器的指定位置 |
| `Center` | `Align(alignment: Alignment.center)` 的简写 |
| `Alignment(x, y)` | x: -1左~1右, y: -1上~1下，中心为(0,0) |

### 4.8 LayoutBuilder 与约束相关组件

| 组件 | 说明 |
|------|------|
| `LayoutBuilder` | 根据父容器约束动态构建不同布局（响应式关键组件） |
| `ConstrainedBox` | 给子元素施加额外约束 |
| `UnconstrainedBox` | 解除父约束，让子元素自由决定尺寸 |
| `AspectRatio` | 固定宽高比 |
| `FractionallySizedBox` | 按父容器比例设置尺寸 |
| `LimitedBox` | 仅当父约束无限时生效的最大尺寸限制 |

**响应式布局核心模式 (layout_builder_page.dart:27-50):**
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 400) {
      return Row(children: [...]);  // 宽屏横向
    } else {
      return Column(children: [...]);  // 窄屏纵向
    }
  },
)
```

## 运行方式

```bash
cd ch04_layout_components
flutter pub get
flutter run
```

## 关键设计思想

- **一切皆 Widget**: 布局也是 Widget（Row、Column），组合即布局
- **约束单向传递**: 父→子传约束，子→父传尺寸，避免全局布局计算
- **flex 弹性分配**: Flutter 使用 CSS Flexbox 类似的弹性模型
- **Stack 层叠**: Z轴控制通过代码顺序（后来的在上层）
- **LayoutBuilder 响应式**: 获取实时约束而无需 MediaQuery（MediaQuery 获取的是屏幕尺寸，LayoutBuilder 获取的是当前 Widget 的约束空间）
