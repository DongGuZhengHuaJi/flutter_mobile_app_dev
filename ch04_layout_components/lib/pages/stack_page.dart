import 'package:flutter/material.dart';

/// 4.6 层叠布局: Stack, Positioned

class StackPage extends StatelessWidget {
  const StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Stack 基础 ---
          _sectionTitle('1. Stack 基础 — 未定位 (默认左上角)'),
          SizedBox(
            height: 120,
            child: Stack(
              children: [
                Container(width: double.infinity, height: 120, color: Colors.grey.shade200),
                Container(width: 100, height: 60, color: Colors.red.shade300),
                Container(width: 80, height: 80, color: Colors.blue.shade300),
                Container(width: 60, height: 40, color: Colors.green.shade300),
              ],
            ),
          ),
          const Text('后加入的在上层,不设位置则叠在左上角', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 20),

          // --- Positioned ---
          _sectionTitle('2. Positioned 绝对定位'),
          SizedBox(
            height: 160,
            child: Container(
              color: Colors.grey.shade100,
              child: Stack(
                children: [
                  // top-left
                  Positioned(
                    top: 8,
                    left: 8,
                    child: _box(60, 60, Colors.red.shade300, 'top-left'),
                  ),
                  // top-right
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _box(60, 60, Colors.blue.shade300, 'top-right'),
                  ),
                  // bottom-left
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: _box(60, 60, Colors.green.shade300, 'bottom-left'),
                  ),
                  // bottom-right
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: _box(60, 60, Colors.orange.shade300, 'bottom-right'),
                  ),
                  // center
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(child: _box(70, 70, Colors.purple.withAlpha(180), 'center')),
                  ),
                ],
              ),
            ),
          ),
          const Text('同时设 left+right 或 top+bottom 可拉伸', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 20),

          // --- Stack 对齐 ---
          _sectionTitle('3. Stack - alignment (非定位子元素对齐)'),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(color: Colors.grey.shade200),
                      _box(60, 60, Colors.teal.shade300, 'center'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(color: Colors.grey.shade200),
                      _box(50, 50, Colors.deepOrange.shade300, 'bottomRight'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text('alignment 属性控制未使用 Positioned 的子元素位置', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 20),

          // --- 实战: 头像角标 ---
          _sectionTitle('4. 实战: 头像 + 在线角标'),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 绿点 (在线)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(radius: 28, backgroundColor: Colors.blue, child: Text('A', style: TextStyle(color: Colors.white, fontSize: 22))),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white, width: 2)),
                      ),
                    ),
                  ],
                ),
                // 数字角标
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.notifications, size: 36),
                    Positioned(
                      right: -6,
                      top: -6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                        constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                        alignment: Alignment.center,
                        child: const Text('5', style: TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // --- IndexedStack ---
          _sectionTitle('5. IndexedStack (只显示指定子元素)'),
          SizedBox(
            height: 100,
            child: IndexedStack(
              index: 1, // 只显示索引为1的子元素
              alignment: Alignment.center,
              children: [
                _box(80, 50, Colors.red.shade200, 'Page 0'),
                _box(80, 50, Colors.blue.shade200, 'Page 1 (显示)'),
                _box(80, 50, Colors.green.shade200, 'Page 2'),
              ],
            ),
          ),
          const Text('IndexedStack 切换显示，保留所有子元素状态 (常用于底部Tab)', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _box(double w, double h, Color color, String label) {
    return Container(
      width: w,
      height: h,
      color: color,
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
    );
  }
}
