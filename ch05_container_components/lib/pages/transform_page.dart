import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 5.3 变换: Transform, RotatedBox

class TransformPage extends StatelessWidget {
  const TransformPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 旋转 ---
          _sectionTitle('1. Transform.rotate (旋转)'),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              Transform.rotate(angle: 0.3, child: _box('30°', Colors.red)),
              Transform.rotate(angle: -0.3, child: _box('-30°', Colors.blue)),
              Transform.rotate(angle: math.pi / 4, child: _box('45°', Colors.green)),
              Transform.rotate(angle: math.pi / 2, child: _box('90°', Colors.orange)),
            ],
          ),

          const SizedBox(height: 16),

          // --- RotatedBox ---
          _sectionTitle('2. RotatedBox (布局阶段旋转)'),
          Row(
            children: [
              Container(color: Colors.grey.shade100, padding: const EdgeInsets.all(8), child: const Text('正常')),
              const SizedBox(width: 12),
              Container(
                color: Colors.teal.shade50,
                padding: const EdgeInsets.all(8),
                child: const RotatedBox(quarterTurns: 1, child: Text('1/4圈')),
              ),
              const SizedBox(width: 12),
              Container(
                color: Colors.teal.shade50,
                padding: const EdgeInsets.all(8),
                child: const RotatedBox(quarterTurns: 3, child: Text('3/4圈')),
              ),
            ],
          ),
          const Text('RotatedBox 在布局阶段生效，影响父容器的空间分配', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 16),

          // --- 缩放 ---
          _sectionTitle('3. Transform.scale (缩放)'),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              Transform.scale(scale: 1.5, child: _box('x1.5', Colors.purple)),
              Transform.scale(scale: 0.7, child: _box('x0.7', Colors.cyan)),
              Transform.scale(scaleX: 1.5, scaleY: 0.7, child: _box('宽1.5\n高0.7', Colors.amber)),
            ],
          ),

          const SizedBox(height: 16),

          // --- 平移 ---
          _sectionTitle('4. Transform.translate (平移)'),
          Container(
            height: 80,
            color: Colors.grey.shade100,
            child: Stack(
              children: [
                Transform.translate(offset: const Offset(10, 10), child: _box('(10,10)', Colors.red.shade300)),
                Transform.translate(offset: const Offset(60, 30), child: _box('(60,30)', Colors.blue.shade300)),
              ],
            ),
          ),
          const Text('Transform.translate 不影响布局空间，仅视觉偏移', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 16),

          // --- 翻转 ---
          _sectionTitle('5. Transform (翻转效果)'),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(0.5),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: const Text('3D\nY轴', style: TextStyle(color: Colors.white)),
            ),
          ),
          const Text('Matrix4 支持 3D 变换（倾斜、透视等）', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 16),

          // --- 实战 ---
          _sectionTitle('6. 实战: 旋转卡片 + 缩放动画'),
          Center(
            child: Transform.rotate(
              angle: 0.05,
              child: Transform.scale(
                scale: 1.05,
                child: Container(
                  width: 160,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.deepPurple, Colors.blue]),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.deepPurple.withAlpha(100), blurRadius: 12)],
                  ),
                  alignment: Alignment.center,
                  child: const Text('倾斜名片', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _box(String label, Color color) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11), textAlign: TextAlign.center),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange)));
  }
}
