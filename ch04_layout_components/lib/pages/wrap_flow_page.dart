import 'dart:math';
import 'package:flutter/material.dart';

/// 4.5 流式布局: Wrap, Flow

class WrapFlowPage extends StatelessWidget {
  const WrapFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Wrap 基础 ---
          _sectionTitle('1. Wrap 基础 (自动换行)'),
          _demoBox(
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(10, (i) => _chip('标签${i + 1}', Colors.teal)),
            ),
            'spacing: 8, runSpacing: 8',
          ),

          const SizedBox(height: 16),

          // --- Wrap 主轴对齐 ---
          _sectionTitle('2. Wrap - alignment (主轴对齐)'),
          _demoBox(
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: List.generate(5, (i) => _chip('居中$i', Colors.blue)),
            ),
            'WrapAlignment.center',
          ),
          const SizedBox(height: 8),
          _demoBox(
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.spaceAround,
              children: List.generate(5, (i) => _chip('分散$i', Colors.blue)),
            ),
            'WrapAlignment.spaceAround',
          ),

          const SizedBox(height: 16),

          // --- Wrap 交叉轴对齐 ---
          _sectionTitle('3. Wrap - runAlignment (交叉轴对齐)'),
          SizedBox(
            height: 120,
            child: _demoBox(
              Wrap(
                spacing: 8,
                runSpacing: 8,
                runAlignment: WrapAlignment.center,
                children: [
                  _tallChip('高', 60),
                  _tallChip('矮', 30),
                  _tallChip('中', 45),
                  _tallChip('矮', 35),
                  _tallChip('高', 55),
                ],
              ),
              '混合高度子项 - runAlignment: center',
            ),
          ),

          const SizedBox(height: 16),

          // --- Wrap 方向 ---
          _sectionTitle('4. Wrap - direction / verticalDirection'),
          _demoBox(
            Wrap(
              direction: Axis.vertical,
              spacing: 8,
              runSpacing: 8,
              children: List.generate(8, (i) => _chip('V$i', Colors.deepPurple)),
            ),
            'direction: Axis.vertical (先纵后横)',
          ),

          const SizedBox(height: 16),

          // --- Flow ---
          _sectionTitle('5. Flow (Delegate模式 — 自定义布局逻辑)'),
          SizedBox(
            height: 120,
            child: Flow(
              delegate: _ArcFlowDelegate(radius: 150),
              children: List.generate(7, (i) {
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade300,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  alignment: Alignment.center,
                  child: Text('$i', style: const TextStyle(color: Colors.white, fontSize: 12)),
                );
              }),
            ),
          ),
          const SizedBox(height: 4),
          const Text('Flow 弧形排列 (自定义Delegate)', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 16),

          // --- chip 流式选标签 ---
          _sectionTitle('6. 实战: Chip 流式标签'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilterChip(label: const Text('Flutter'), selected: true, onSelected: (_) {}),
              FilterChip(label: const Text('Dart'), selected: false, onSelected: (_) {}),
              FilterChip(label: const Text('Android'), selected: true, onSelected: (_) {}),
              FilterChip(label: const Text('iOS'), selected: false, onSelected: (_) {}),
              FilterChip(label: const Text('Web'), selected: true, onSelected: (_) {}),
              FilterChip(label: const Text('Desktop'), selected: false, onSelected: (_) {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _tallChip(String label, double height) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.teal.shade300, borderRadius: BorderRadius.circular(8)),
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _demoBox(Widget child, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
          child: child,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
    );
  }
}

/// 自定义 FlowDelegate — 弧形排列
class _ArcFlowDelegate extends FlowDelegate {
  final double radius;

  _ArcFlowDelegate({required this.radius});

  @override
  void paintChildren(FlowPaintingContext context) {
    final count = context.childCount;
    for (int i = 0; i < count; i++) {
      final angle = (i / (count - 1) - 0.5) * 1.2; // -0.6 ~ 0.6 弧度
      final x = context.size.width / 2 + radius * sin(angle) - context.getChildSize(i)!.width / 2;
      final y = radius * (1 - cos(angle));
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(covariant _ArcFlowDelegate oldDelegate) => oldDelegate.radius != radius;

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, radius * 0.4);
  }
}
