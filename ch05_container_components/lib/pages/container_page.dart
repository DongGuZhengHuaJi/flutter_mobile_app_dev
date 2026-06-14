import 'package:flutter/material.dart';

/// 5.4 Container — 组合容器（Padding + DecoratedBox + Constraints + Transform + Align 等）

class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Container = 多组件组合'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: const Text(
              'Container 本质上是一个组合了 Padding、DecoratedBox、ConstrainedBox、'
              'Transform、Align 等组件的便利容器。',
              style: TextStyle(color: Colors.deepOrange),
            ),
          ),

          const SizedBox(height: 16),

          _sectionTitle('1. 只设 width/height — 无子元素时按指定尺寸'),
          Container(width: 100, height: 60, color: Colors.blue.shade300),

          const SizedBox(height: 16),

          _sectionTitle('2. width + child — 约束传递'),
          Container(
            width: 200,
            color: Colors.grey.shade200,
            child: const Text('Container 宽度200，文本自然折行展示效果', softWrap: true),
          ),

          const SizedBox(height: 16),

          _sectionTitle('3. decoration + padding + margin'),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal, width: 2),
            ),
            child: const Text('margin(外) > decoration(背景) > padding(内) > child'),
          ),
          const Text('层级: margin → decoration → padding → child', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 16),

          _sectionTitle('4. margin vs padding 可视化'),
          Stack(
            children: [
              // margin 区域
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  border: Border.all(color: Colors.red.shade300, width: 1),
                ),
                child: const SizedBox(height: 40),
              ),
              const Positioned(left: 8, top: 2, child: Text('margin', style: TextStyle(fontSize: 11, color: Colors.red))),
              // padding 区域
              Positioned(
                left: 16,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    border: Border.all(color: Colors.blue.shade300),
                  ),
                  child: Container(height: 30, color: Colors.blue.shade300, alignment: Alignment.center, child: const Text('child', style: TextStyle(color: Colors.white, fontSize: 11))),
                ),
              ),
              const Positioned(left: 20, top: 2, child: Text('padding', style: TextStyle(fontSize: 11, color: Colors.blue))),
            ],
          ),

          const SizedBox(height: 20),

          _sectionTitle('5. 对齐方式 alignment'),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Text('center'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.grey.shade200,
                  alignment: Alignment.bottomRight,
                  child: const Text('bottomRight', style: TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange)));
  }
}
