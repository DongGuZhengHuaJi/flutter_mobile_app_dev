# 第8章：事件处理与通知

基于《Flutter实战·第二版》第8章内容，深入理解 Flutter 事件体系和跨组件通信。

## 章节知识图谱

```
事件处理与通知 (ch08)
├── 8.1 原始指针事件 ──── Listener, PointerEvent, 命中测试(hitTest)
├── 8.2 手势识别 ──────── GestureDetector, 各种手势回调
├── 8.4 手势原理与冲突 ── 手势竞技场(GestureArena), 竞争/胜出
├── 8.5 事件总线 ──────── EventBus, StreamController.broadcast
└── 8.6 通知 ──────────── NotificationListener, 自定义 Notification
```

## 项目结构

```
ch08_event_handling/
├── lib/
│   ├── main.dart                   # 应用入口 + 底部导航
│   └── pages/
│       ├── pointer_page.dart       # 8.1 原始指针事件 (Listener)
│       ├── gesture_page.dart       # 8.2+8.4 手势识别与手势冲突
│       ├── event_bus_page.dart     # 8.5 事件总线 (EventBus)
│       └── notification_page.dart  # 8.6 通知 (Notification)
├── pubspec.yaml
└── README.md
```

## 核心知识点

### 8.1 原始指针事件 (Listener)

| 事件 | 说明 |
|------|------|
| `onPointerDown` | 手指按下 |
| `onPointerMove` | 手指移动 |
| `onPointerUp` | 手指抬起 |
| `onPointerCancel` | 事件取消（如来电打断） |

**事件阻断机制:**

| 组件 | 说明 |
|------|------|
| `AbsorbPointer` | 阻断子树接收指针事件（自身可接收） |
| `IgnorePointer` | 忽略子树指针事件（自身和子树都不可交互） |

**关键代码 (pointer_page.dart:33-58) — Listener 监听:**
```dart
Listener(
  onPointerDown: (e) => print('DOWN at ${e.localPosition}'),
  onPointerMove: (e) => print('MOVE at ${e.localPosition}'),
  onPointerUp: (e) => print('UP'),
  child: ...,
)
```

### 8.2 手势识别 (GestureDetector)

| 手势回调 | 触发条件 |
|----------|----------|
| `onTap` | 点击（Down + Up 在短时间/短距离内） |
| `onDoubleTap` | 双击 |
| `onLongPress` | 长按 |
| `onPanStart/Update/End` | 平移/拖拽 |
| `onScaleStart/Update/End` | 缩放（多指） |
| `onHorizontalDrag...` | 水平拖拽 |
| `onVerticalDrag...` | 垂直拖拽 |

**Dismissible — 滑动操作组件 (gesture_page.dart:68-95):**
```dart
Dismissible(
  key: UniqueKey(),
  background: Container(color: Colors.red, child: Icon(Icons.delete)),
  confirmDismiss: (direction) async => true,
  onDismissed: (direction) => print('dismissed'),
  child: ListTile(...),
)
```

### 8.4 手势竞争 — 手势竞技场

Flutter 内部通过 GestureArena 机制解决手势冲突：

1. 多个 GestureDetector 同时参与同一指针事件
2. 每个手势识别器进入"竞技场"竞争
3. 最先满足条件的手势"胜出"，其他"失败"
4. **子节点优先于父节点**（HitTest 顺序）

**同父容器内竞争:**
- 水平拖拽 vs 垂直拖拽 → 由滑动方向判定（水平偏移 > 垂直偏移 → 水平胜出）

### 8.5 事件总线 (EventBus)

**设计模式要点:**
1. **单例模式**: 全局唯一 EventBus 实例
2. **StreamController.broadcast()**: 支持多订阅者的广播流
3. **解耦通信**: 发布者和订阅者无需相互引用

**实现 (event_bus_page.dart:19-35):**
```dart
class EventBus {
  static final EventBus _instance = EventBus._();
  factory EventBus() => _instance;
  EventBus._();

  final StreamController<CartEvent> _controller =
      StreamController<CartEvent>.broadcast();

  void fire(CartEvent event) => _controller.add(event);
  Stream<CartEvent> get onCartEvent => _controller.stream;
}

// 发布事件
EventBus().fire(CartEvent('iPhone', CartAction.add));

// 订阅事件
EventBus().onCartEvent.listen((event) {
  print('${event.action} ${event.itemName}');
});
```

**应用场景:** 购物车、跨页面状态同步、全局消息通知

### 8.6 通知 (Notification)

**与 EventBus 的关键区别:**

| 特性 | EventBus | Notification |
|------|----------|-------------|
| 传递方向 | 任意方向（全局） | 自下而上（沿 Widget 树冒泡） |
| 订阅方式 | Stream 订阅 | NotificationListener 拦截 |
| 生命周期 | 手动管理 StreamSubscription | Widget 树自动管理 |
| 适用场景 | 跨页面/全局通信 | 子组件→父组件通信 |

**自定义 Notification (notification_page.dart:9-13):**
```dart
class MyNotification extends Notification {
  final String message;
  final int value;
  MyNotification(this.message, this.value);
}

// 子组件发送通知
MyNotification('警告', 99).dispatch(context);

// 父组件拦截通知
NotificationListener<MyNotification>(
  onNotification: (notification) {
    // 返回 true 拦截 (不再向上冒泡)
    // 返回 false 继续向上传递
    return notification.value > 50;
  },
  child: ...,
)
```

**ScrollNotification 类型:**
| 类型 | 说明 |
|------|------|
| `ScrollStartNotification` | 滚动开始 |
| `ScrollUpdateNotification` | 滚动中（持续触发，可获取 pixels/maxScrollExtent） |
| `ScrollEndNotification` | 滚动结束 |
| `OverscrollNotification` | 过度滚动 |
| `UserScrollNotification` | 区分用户拖动 vs 程序滚动 |

## 运行方式

```bash
cd ch08_event_handling
flutter pub get
flutter run
```

## 关键架构概念

1. **命中测试 (HitTest)**: Flutter 从根节点向下遍历 RenderObject 树，确定哪些组件在触摸点范围内
2. **事件冒泡顺序**: 最内层子组件先接收，逐层向上
3. **手势竞技场**: 多手势冲突时，由系统自动判定最优手势
4. **EventBus vs Notification**: 全局通信用 EventBus，父子组件通信用 Notification
5. **StreamSubscription 生命周期**: 务必在 dispose() 中 cancel()，避免内存泄漏
