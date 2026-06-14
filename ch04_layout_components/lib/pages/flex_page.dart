import 'package:flutter/material.dart';

/// 4.4 弹性布局: Flex, Expanded, Flexible, Spacer

class FlexPage extends StatelessWidget {
  const FlexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Expanded ---
          _sectionTitle('1. Expanded (按 flex 比例分配剩余空间)'),
          _demoBox(
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(height: 50, color: Colors.red.shade300, child: const Center(child: Text('flex: 2', style: TextStyle(color: Colors.white)))),
                ),
                Expanded(
                  flex: 1,
                  child: Container(height: 50, color: Colors.blue.shade300, child: const Center(child: Text('flex: 1', style: TextStyle(color: Colors.white)))),
                ),
                Expanded(
                  flex: 3,
                  child: Container(height: 50, color: Colors.green.shade300, child: const Center(child: Text('flex: 3', style: TextStyle(color: Colors.white)))),
                ),
              ],
            ),
            'Row 中 flex 比例: 2:1:3',
          ),

          const SizedBox(height: 16),

          // --- 不设 flex (自然大小) + Expanded ---
          _sectionTitle('2. 固定大小 + Expanded 混合'),
          _demoBox(
            Row(
              children: [
                Container(width: 60, height: 50, color: Colors.orange, child: const Center(child: Text('60px', style: TextStyle(color: Colors.white, fontSize: 11)))),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(height: 50, color: Colors.teal.shade300, child: const Center(child: Text('Expanded 填满剩余', style: TextStyle(color: Colors.white)))),
                ),
              ],
            ),
            '固定60 + Expanded 占满剩余',
          ),

          const SizedBox(height: 16),

          // --- Flexible ---
          _sectionTitle('3. Flexible (与 Expanded 的区别: 可以不填满)'),
          _demoBox(
            Row(
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight, // 等同于 Expanded
                  child: Container(height: 50, color: Colors.purple.shade300, child: const Center(child: Text('tight (填满)', style: TextStyle(color: Colors.white)))),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose, // 不强制填满
                  child: Container(height: 50, color: Colors.amber.shade300, child: const Center(child: Text('loose (内容撑开)', style: TextStyle(color: Colors.white)))),
                ),
              ],
            ),
            'FlexFit.tight vs FlexFit.loose',
          ),

          const SizedBox(height: 16),

          // --- Spacer ---
          _sectionTitle('4. Spacer (弹性空白)'),
          _demoBox(
            Column(
              children: [
                Row(
                  children: [
                    _chip('Left'),
                    const Spacer(),
                    _chip('Right'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _chip('A'),
                    const Spacer(flex: 2),
                    _chip('B'),
                    const Spacer(flex: 1),
                    _chip('C'),
                  ],
                ),
              ],
            ),
            'Spacer: 等距 / 不等距分布',
          ),

          const SizedBox(height: 16),

          // --- Column + Expanded ---
          _sectionTitle('5. Column 中的 Expanded (垂直方向)'),
          SizedBox(
            height: 200,
            child: _demoBox(
              Column(
                children: [
                  Container(height: 40, color: Colors.red.shade200, alignment: Alignment.center, child: const Text('固定 40', style: TextStyle(color: Colors.white))),
                  Expanded(
                    flex: 2,
                    child: Container(color: Colors.green.shade200, alignment: Alignment.center, child: const Text('Expanded flex:2', style: TextStyle(color: Colors.white))),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(color: Colors.blue.shade200, alignment: Alignment.center, child: const Text('Expanded flex:1', style: TextStyle(color: Colors.white))),
                  ),
                ],
              ),
              'Column 中: 固定40 + flex 2:1',
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.teal.shade400, borderRadius: BorderRadius.circular(16)),
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
