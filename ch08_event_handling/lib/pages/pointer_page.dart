import 'package:flutter/material.dart';

/// 8.1 原始指针事件处理
/// 演示: Listener, PointerDown/Move/Up, 事件冒泡, 命中测试 (hitTest)

class PointerPage extends StatefulWidget {
  const PointerPage({super.key});

  @override
  State<PointerPage> createState() => _PointerPageState();
}

class _PointerPageState extends State<PointerPage> {
  String _log = '在下方区域触摸查看指针事件...';
  Offset? _lastPosition;

  void _addLog(String msg) {
    setState(() => _log = '$msg\n$_log'.substring(0, _log.length > 500 ? 500 : _log.length + msg.length + 1));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('1. Listener — 监听原始指针事件'),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.indigo.shade200, width: 2),
            ),
            child: Listener(
              onPointerDown: (e) {
                _addLog('↓ DOWN  (local: ${e.localPosition.dx.toInt()}, ${e.localPosition.dy.toInt()})');
                setState(() => _lastPosition = e.localPosition);
              },
              onPointerMove: (e) {
                _addLog('↔ MOVE  (${e.localPosition.dx.toInt()}, ${e.localPosition.dy.toInt()})');
                setState(() => _lastPosition = e.localPosition);
              },
              onPointerUp: (e) {
                _addLog('↑ UP');
                setState(() => _lastPosition = null);
              },
              onPointerCancel: (e) => _addLog('✕ CANCEL'),
              child: Stack(
                children: [
                  const Center(child: Text('触摸区域', style: TextStyle(color: Colors.indigo))),
                  if (_lastPosition != null)
                    Positioned(
                      left: _lastPosition!.dx - 15,
                      top: _lastPosition!.dy - 15,
                      child: Container(width: 30, height: 30, decoration: BoxDecoration(color: Colors.red.withAlpha(120), borderRadius: BorderRadius.circular(15))),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 事件日志
          Container(
            width: double.infinity,
            height: 160,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(8)),
            child: SingleChildScrollView(
              reverse: true,
              child: Text(_log, style: const TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', fontSize: 12)),
            ),
          ),

          const SizedBox(height: 16),

          _sectionTitle('2. 事件冒泡 (行为对比)'),
          Row(
            children: [
              Expanded(
                child: _eventBox(
                  '默认 (冒泡)',
                  Colors.blue,
                  child: Listener(
                    onPointerDown: (_) => _addLog('【子】DOWN (冒泡)'),
                    child: Container(height: 60, color: Colors.red.shade200, alignment: Alignment.center, child: const Text('子', style: TextStyle(color: Colors.white))),
                  ),
                  onDown: () => _addLog('【父】DOWN'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _eventBox(
                  'AbsorbPointer (阻断)',
                  Colors.grey,
                  child: AbsorbPointer(
                    child: Listener(
                      onPointerDown: (_) => _addLog('【子】DOWN (被阻断)'),
                      child: Container(height: 60, color: Colors.red.shade200, alignment: Alignment.center, child: const Text('子', style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  onDown: () => _addLog('【父】DOWN (子被阻断)'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _eventBox(
                  'IgnorePointer (忽略)',
                  Colors.grey,
                  child: IgnorePointer(
                    child: Listener(
                      onPointerDown: (_) => _addLog('【子】DOWN (被忽略)'),
                      child: Container(height: 60, color: Colors.red.shade200, alignment: Alignment.center, child: const Text('子', style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  onDown: () => _addLog('【父】DOWN (忽略子)'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              'AbsorbPointer: 阻断事件但自身可接收 | IgnorePointer: 完全忽略(自身和子都不可交互)',
              style: TextStyle(fontSize: 13, color: Colors.indigo),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventBox(String label, Color color, {required Widget child, required VoidCallback onDown}) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: color)),
        const SizedBox(height: 4),
        Listener(
          onPointerDown: (_) => onDown(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withAlpha(30), borderRadius: BorderRadius.circular(8)),
            child: child,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)));
  }
}
