import 'package:flutter/material.dart';

/// 8.2 手势识别 + 8.4 手势原理与手势冲突
/// 演示: GestureDetector, 各种手势, 手势竞技场

class GesturePage extends StatefulWidget {
  const GesturePage({super.key});

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  String _gestureLog = '';
  int _tapCount = 0;
  int _doubleTapCount = 0;
  int _longPressCount = 0;
  double _scale = 1.0;
  Offset _panOffset = Offset.zero;
  String _dragResult = '';

  void _log(String msg) {
    setState(() => _gestureLog = '$msg\n$_gestureLog');
    if (_gestureLog.length > 300) _gestureLog = _gestureLog.substring(0, 300);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 基本手势 ---
          _sectionTitle('1. 点击 (onTap / onDoubleTap / onLongPress)'),
          GestureDetector(
            onTap: () {
              _tapCount++;
              _log('Tap! (共$_tapCount次)');
            },
            onDoubleTap: () {
              _doubleTapCount++;
              _log('DoubleTap! (共$_doubleTapCount次)');
            },
            onLongPress: () {
              _longPressCount++;
              _log('LongPress! (共$_longPressCount次)');
            },
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(color: Colors.indigo.shade100, borderRadius: BorderRadius.circular(12)),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tap: $_tapCount | DoubleTap: $_doubleTapCount | LongPress: $_longPressCount'),
                  const SizedBox(height: 4),
                  const Text('点击/双击/长按 测试', style: TextStyle(color: Colors.indigo, fontSize: 13)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // --- 缩放 ---
          _sectionTitle('2. 缩放 (onScaleUpdate)'),
          GestureDetector(
            onScaleUpdate: (details) {
              setState(() => _scale = (_scale * details.scale).clamp(0.5, 3.0));
              _log('缩放: ${_scale.toStringAsFixed(2)}x');
            },
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
              alignment: Alignment.center,
              child: Transform.scale(
                scale: _scale,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                  alignment: Alignment.center,
                  child: Text('${_scale.toStringAsFixed(1)}x', style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          const Text('双指捏合缩放 (需真机或模拟器)', style: TextStyle(fontSize: 11, color: Colors.grey)),

          const SizedBox(height: 16),

          // --- 平移 ---
          _sectionTitle('3. 拖拽/平移 (onPanUpdate)'),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() => _panOffset += details.delta);
            },
            onPanEnd: (_) => _log('拖动结束: (${_panOffset.dx.toInt()}, ${_panOffset.dy.toInt()})'),
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: [
                  const Center(child: Text('拖动蓝色方块', style: TextStyle(color: Colors.orange))),
                  Positioned(
                    left: _panOffset.dx + 20,
                    top: _panOffset.dy + 40,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.blue.withAlpha(100), blurRadius: 4)]),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // --- 滑动删除 ---
          _sectionTitle('4. Dismissible (滑动删除)'),
          Dismissible(
            key: ValueKey(DateTime.now().millisecondsSinceEpoch),
            direction: DismissDirection.horizontal,
            background: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.archive, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                _log('已删除');
                return true;
              }
              _log('已归档');
              return true;
            },
            onDismissed: (direction) {
              setState(() => _dragResult = direction == DismissDirection.startToEnd ? '已删除' : '已归档');
            },
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: const ListTile(
                leading: Icon(Icons.phone_android),
                title: Text('← 左滑删除 | 右滑归档 →'),
                subtitle: Text('Dismissible 组件'),
              ),
            ),
          ),
          if (_dragResult.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('操作结果: $_dragResult', style: const TextStyle(color: Colors.green)),
            ),

          const SizedBox(height: 20),

          // --- 手势竞技场 ---
          _sectionTitle('5. 手势竞争 (GestureArena)'),
          Container(
            width: double.infinity,
            height: 80,
            color: Colors.grey.shade100,
            child: GestureDetector(
              onHorizontalDragStart: (_) => _log('→ 水平拖拽胜出'),
              child: GestureDetector(
                onVerticalDragStart: (_) => _log('↓ 垂直拖拽胜出'),
                child: const Center(child: Text('水平 vs 垂直拖拽竞争\n(手势竞技场自动判定)', textAlign: TextAlign.center, style: TextStyle(color: Colors.indigo))),
              ),
            ),
          ),
          const Text('手势竞技场: 同方向手势竞争时,子节点优先; 垂直与水平竞争时由滑动方向判定', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)));
  }
}
