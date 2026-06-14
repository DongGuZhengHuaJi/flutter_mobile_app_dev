import 'package:flutter/material.dart';

/// 5.6 空间适配: FittedBox

class FittedBoxPage extends StatelessWidget {
  const FittedBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('1. FittedBox — 缩放子元素以适配父容器'),
          _demoBox(
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.grey.shade200,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.teal,
                  child: const Text('长文本会被缩放以适配父容器宽度', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
            'BoxFit.contain — 等比缩放适配',
          ),

          const SizedBox(height: 16),

          _sectionTitle('2. BoxFit 模式对比'),
          ...BoxFit.values.map((fit) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _demoBox(
                Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.grey.shade200,
                  child: FittedBox(
                    fit: fit,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: Colors.deepOrange,
                      child: const Text('FitDemo', style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
                fit.name,
              ),
            );
          }),

          const SizedBox(height: 16),

          _sectionTitle('3. FittedBox + 不同子元素尺寸'),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 80,
                  color: Colors.grey.shade100,
                  child: FittedBox(
                    child: Container(width: 200, height: 30, color: Colors.blue.shade300, alignment: Alignment.center, child: const Text('200x30 → 缩放到80', style: TextStyle(color: Colors.white))),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 80,
                  color: Colors.grey.shade100,
                  child: FittedBox(
                    child: Container(width: 30, height: 100, color: Colors.green.shade300, alignment: Alignment.center, child: const Text('30x100→缩放', style: TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center)),
                  ),
                ),
              ),
            ],
          ),
          const Text('FittedBox 根据宽高比自动缩放，不同方向都能适配', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 20),

          _sectionTitle('4. 实战: 自适应文本大小'),
          _demoBox(
            SizedBox(
              width: 200,
              child: FittedBox(
                child: Text(
                  '这段文本可能很长',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.purple.shade300),
                ),
              ),
            ),
            '长文本在200px宽度下自动缩放',
          ),
        ],
      ),
    );
  }

  Widget _demoBox(Widget child, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: double.infinity, padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: child),
        Padding(padding: const EdgeInsets.only(top: 4), child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey))),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange)));
  }
}
