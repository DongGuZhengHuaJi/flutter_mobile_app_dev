import 'package:flutter/material.dart';

/// 5.2 装饰容器: DecoratedBox, BoxDecoration, 圆角, 阴影, 渐变, 边框

class DecoratedBoxPage extends StatelessWidget {
  const DecoratedBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 圆角 ---
          _sectionTitle('1. borderRadius (圆角)'),
          Row(
            children: [
              _decoItem(
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const SizedBox(width: 80, height: 80),
                ),
                'circular(16)',
              ),
              const SizedBox(width: 12),
              _decoItem(
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  ),
                  child: const SizedBox(width: 80, height: 80),
                ),
                'only(TL, BR)',
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- 边框 ---
          _sectionTitle('2. border (边框)'),
          _decoItem(
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                border: Border.all(color: Colors.amber, width: 3),
              ),
              child: const SizedBox(width: 100, height: 60),
            ),
            'all(amber, 3)',
          ),
          const SizedBox(height: 8),
          _decoItem(
            DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.red, width: 3),
                  bottom: BorderSide(color: Colors.blue, width: 3),
                  left: BorderSide(color: Colors.green, width: 3),
                  right: BorderSide(color: Colors.orange, width: 3),
                ),
              ),
              child: const SizedBox(width: 100, height: 60),
            ),
            '四边不同色',
          ),

          const SizedBox(height: 16),

          // --- 阴影 ---
          _sectionTitle('3. boxShadow (阴影)'),
          Row(
            children: [
              _decoItem(
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 8, offset: Offset(2, 2))],
                  ),
                  child: const SizedBox(width: 80, height: 80),
                ),
                '经典阴影',
              ),
              const SizedBox(width: 12),
              _decoItem(
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.blue.withAlpha(100), blurRadius: 12, spreadRadius: 2),
                    ],
                  ),
                  child: const SizedBox(width: 80, height: 80),
                ),
                '发光效果',
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- 渐变 ---
          _sectionTitle('4. gradient (渐变)'),
          _decoItem(
            DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: const SizedBox(width: 200, height: 60),
            ),
            'LinearGradient (线形渐变)',
          ),
          const SizedBox(height: 8),
          _decoItem(
            DecoratedBox(
              decoration: const BoxDecoration(
                gradient: RadialGradient(colors: [Colors.yellow, Colors.orange, Colors.red]),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: const SizedBox(width: 200, height: 60),
            ),
            'RadialGradient (径向渐变)',
          ),
          const SizedBox(height: 8),
          _decoItem(
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: const SweepGradient(colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple, Colors.red]),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const SizedBox(width: 100, height: 100),
            ),
            'SweepGradient (扫描渐变)',
          ),

          const SizedBox(height: 16),

          // --- 形状 ---
          _sectionTitle('5. shape (形状)'),
          Row(
            children: [
              _decoItem(
                DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.deepPurple, shape: BoxShape.circle),
                  child: const SizedBox(width: 80, height: 80),
                ),
                'circle',
              ),
              const SizedBox(width: 12),
              _decoItem(
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.shade800, width: 2),
                  ),
                  child: const SizedBox(width: 80, height: 80),
                ),
                'rectangle',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _decoItem(Widget child, String label) {
    return Column(
      children: [
        child,
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange)));
  }
}
