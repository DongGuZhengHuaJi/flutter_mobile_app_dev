# 第5章：容器类组件

基于《Flutter实战·第二版》第5章内容，详解 Flutter 各类容器组件。

## 章节知识图谱

```
容器类组件 (ch05)
├── 5.1 填充 ───────── Padding, EdgeInsets (all/symmetric/only/fromLTRB)
├── 5.2 装饰容器 ───── DecoratedBox, BoxDecoration, BoxShadow, Gradient
├── 5.3 变换 ───────── Transform.rotate/scale/translate, RotatedBox, Matrix4
├── 5.4 Container ───── 组合容器 (margin + decoration + padding + child)
├── 5.5 剪裁 ───────── ClipRect, ClipRRect, ClipOval, ClipPath, CustomClipper
├── 5.6 空间适配 ───── FittedBox, BoxFit
└── 5.7 页面骨架 ───── Scaffold, AppBar, Drawer, BottomSheet, SnackBar
```

## 项目结构

```
ch05_container_components/
├── lib/
│   ├── main.dart                    # 应用入口 + 底部导航
│   └── pages/
│       ├── padding_page.dart        # 5.1 Padding / EdgeInsets
│       ├── decorated_box_page.dart  # 5.2 DecoratedBox / BoxDecoration
│       ├── transform_page.dart      # 5.3 Transform / RotatedBox
│       ├── container_page.dart      # 5.4 Container 组合容器
│       ├── clip_page.dart           # 5.5 Clip 系列 / CustomClipper
│       ├── fitted_box_page.dart     # 5.6 FittedBox / BoxFit
│       └── scaffold_page.dart       # 5.7 Scaffold 页面骨架
├── pubspec.yaml
└── README.md
```

## 核心知识点

### 5.1 Padding — 内边距

| 构造方法 | 说明 |
|----------|------|
| `EdgeInsets.all(d)` | 四边等距 |
| `EdgeInsets.symmetric(horizontal:, vertical:)` | 水平/垂直对称 |
| `EdgeInsets.only(left:, top:, right:, bottom:)` | 指定边 |
| `EdgeInsets.fromLTRB(l, t, r, b)` | 顺序指定左上右下 |

### 5.2 DecoratedBox — 装饰容器

| 装饰类型 | 说明 |
|----------|------|
| `color` | 背景色 |
| `borderRadius` | 圆角 |
| `border` | 边框（Border.all / 四边独立） |
| `boxShadow` | 阴影列表（可叠加多层阴影） |
| `gradient` | 渐变背景（Linear / Radial / Sweep） |
| `shape` | 形状（circle / rectangle） |

**三种渐变效果 (decorated_box_page.dart):**

```dart
// 线性渐变
LinearGradient(colors: [...], begin: Alignment.topLeft, end: Alignment.bottomRight)

// 径向渐变
RadialGradient(colors: [...], center: Alignment.center)

// 扫描渐变
SweepGradient(colors: [...], startAngle: 0, endAngle: math.pi * 2)
```

### 5.3 Transform — 变换

| 变换方式 | 说明 |
|----------|------|
| `Transform.rotate(angle:)` | 旋转（弧度） |
| `Transform.scale(scale:)` | 缩放 |
| `Transform.translate(offset:)` | 平移 |
| `Transform(transform: Matrix4)` | 4x4 矩阵变换（支持 3D） |
| `RotatedBox(quarterTurns:)` | 布局阶段旋转（影响父容器空间） |

**Transform.rotate vs RotatedBox 关键区别:**
- `Transform.rotate`: 只影响绘制，不影响布局空间，不触发重排
- `RotatedBox`: 在布局阶段旋转，父容器会感知到旋转后的尺寸

### 5.4 Container — 万能组合容器

Container 内部按顺序组合了以下组件：
```
margin → decoration → padding → constraints → transform → alignment → child
```

| 属性 | 效果 |
|------|------|
| `width / height` | 无子元素时指定尺寸；有子元素时作为约束 |
| `color` | 快捷背景色（不能与 decoration 同用） |
| `decoration` | 装饰效果（含背景、边框、圆角、阴影等） |
| `margin` | 外边距（Container 与父节点之间） |
| `padding` | 内边距（Container 边界与 child 之间） |
| `alignment` | 子元素对齐位置 |
| `transform` | 变换 |

### 5.5 Clip — 剪裁系列

| 组件 | 说明 |
|------|------|
| `ClipRect` | 矩形剪裁 |
| `ClipRRect` | 圆角矩形剪裁 |
| `ClipOval` | 圆形/椭圆形剪裁 |
| `ClipPath` | 自定义路径剪裁（需实现 CustomClipper\<Path\>） |

**自定义剪裁路径 (clip_page.dart) — 星形:**
```dart
class _StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // ... 绘制星形路径
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
```

### 5.6 FittedBox — 空间适配

当子元素尺寸超过父容器时，FittedBox 将子元素缩放以适配。

| BoxFit 值 | 效果 |
|-----------|------|
| `contain` | 等比缩放，完整显示（可能留白） |
| `cover` | 等比缩放，填满（可能裁剪） |
| `fill` | 拉伸填满（可能变形） |
| `fitWidth` | 宽度撑满 |
| `fitHeight` | 高度撑满 |
| `none` | 不缩放 |
| `scaleDown` | 仅当超出时等比缩小 |

### 5.7 Scaffold — 页面骨架

| 属性 | 说明 |
|------|------|
| `appBar` | 顶部导航栏（leading + title + actions） |
| `body` | 主体内容 |
| `floatingActionButton` | 浮动按钮 |
| `bottomNavigationBar` | 底部导航栏 |
| `drawer / endDrawer` | 左侧/右侧抽屉菜单 |
| `bottomSheet` | 底部弹出层 |
| `snackBar` | 消息提示条 |

**Scaffold 骨架结构:**
```
┌─────────────────────┐
│      AppBar         │  ← leading | title | actions
├─────────────────────┤
│                     │
│       body          │  ← 主体
│                     │
├─────────────────────┤
│  bottomNavigationBar│
└─────────────────────┘
  FAB (浮动)
```

## 运行方式

```bash
cd ch05_container_components
flutter pub get
flutter run
```

## 关键设计要点

- **Container 的层级顺序**: margin → decoration → padding → child，装饰在 padding 之上
- **Transform vs RotatedBox**: 布局阶段 vs 绘制阶段的旋转，影响是否触发重排
- **Clip 性能**: 频繁变化时避免过度剪裁，可通过 `clipBehavior` 控制（Clip.none 跳过剪裁）
- **CustomClipper.shouldReclip**: 返回 false 可避免不必要的重剪裁
