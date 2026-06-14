import 'package:flutter/material.dart';

/// 5.1 填充: Padding, EdgeInsets

class PaddingPage extends StatelessWidget {
  const PaddingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('1. EdgeInsets.all (四边等距)'),
          _demoBox(
            Row(
              children: List.generate(3, (i) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.teal.shade400,
                    alignment: Alignment.center,
                    child: Text('all\n12', style: const TextStyle(color: Colors.white, fontSize: 11), textAlign: TextAlign.center),
                  ),
                );
              }),
            ),
            'EdgeInsets.all(12) — 四边各12内边距',
          ),

          const SizedBox(height: 16),

          _sectionTitle('2. EdgeInsets.symmetric (水平/垂直对称)'),
          _demoBox(
            Container(
              color: Colors.teal.shade400,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: const Text('水平32 + 垂直16', style: TextStyle(color: Colors.white)),
            ),
            'EdgeInsets.symmetric(horizontal: 32, vertical: 16)',
          ),

          const SizedBox(height: 16),

          _sectionTitle('3. EdgeInsets.only (指定边)'),
          _demoBox(
            Row(
              children: [
                _paddedBox('L20', EdgeInsets.only(left: 20)),
                const SizedBox(width: 8),
                _paddedBox('T20', EdgeInsets.only(top: 20)),
                const SizedBox(width: 8),
                _paddedBox('R20', EdgeInsets.only(right: 20)),
                const SizedBox(width: 8),
                _paddedBox('B20', EdgeInsets.only(bottom: 20)),
              ],
            ),
            'EdgeInsets.only(left/top/right/bottom) — 指定单边',
          ),

          const SizedBox(height: 16),

          _sectionTitle('4. EdgeInsets.fromLTRB (左上右下)'),
          _demoBox(
            _paddedBox('LTRB', const EdgeInsets.fromLTRB(24, 8, 4, 16)),
            'EdgeInsets.fromLTRB(24, 8, 4, 16) — 左24 上8 右4 下16',
          ),

          const SizedBox(height: 20),

          _sectionTitle('5. 实际应用: 卡片内边距对比'),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: _cardDecoration,
                  child: Column(
                    children: [
                      Container(height: 40, color: Colors.blue.shade200),
                      const SizedBox(height: 4),
                      const Text('padding: 8', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: _cardDecoration,
                  child: Column(
                    children: [
                      Container(height: 40, color: Colors.blue.shade200),
                      const SizedBox(height: 4),
                      const Text('padding: 20', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration get _cardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
      );

  Widget _paddedBox(String label, EdgeInsets padding) {
    return Container(
      width: 70,
      height: 70,
      color: Colors.orange.shade100,
      child: Container(
        color: Colors.orange.shade400,
        padding: padding,
        alignment: Alignment.center,
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
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
