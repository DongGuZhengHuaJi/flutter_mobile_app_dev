import 'package:flutter/material.dart';

/// 4.7 对齐与相对定位: Align, Center

class AlignPage extends StatelessWidget {
  const AlignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Align ---
          _sectionTitle('1. Align — 九宫格定位'),
          SizedBox(
            height: 180,
            child: Container(
              color: Colors.grey.shade100,
              child: GridView.count(
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1,
                children: const [
                  Align(alignment: Alignment.topLeft, child: _Dot('TL', Colors.red)),
                  Align(alignment: Alignment.topCenter, child: _Dot('TC', Colors.blue)),
                  Align(alignment: Alignment.topRight, child: _Dot('TR', Colors.green)),
                  Align(alignment: Alignment.centerLeft, child: _Dot('CL', Colors.orange)),
                  Align(alignment: Alignment.center, child: _Dot('C', Colors.purple)),
                  Align(alignment: Alignment.centerRight, child: _Dot('CR', Colors.teal)),
                  Align(alignment: Alignment.bottomLeft, child: _Dot('BL', Colors.pink)),
                  Align(alignment: Alignment.bottomCenter, child: _Dot('BC', Colors.indigo)),
                  Align(alignment: Alignment.bottomRight, child: _Dot('BR', Colors.cyan)),
                ],
              ),
            ),
          ),
          const Text('Align 将子元素定位到父容器的指定位置 (Alignment(x, y)，范围 -1.0 ~ 1.0)', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 20),

          // --- 自定义 Alignment ---
          _sectionTitle('2. Alignment 自定义坐标'),
          SizedBox(
            height: 120,
            child: Container(
              color: Colors.grey.shade100,
              child: Stack(
                children: [
                  // 原心位置
                  Align(
                    alignment: const Alignment(0, 0),
                    child: Container(width: 6, height: 6, color: Colors.red),
                  ),
                  // 自定义位置
                  Align(
                    alignment: const Alignment(0.5, -0.5),
                    child: _dot('(0.5, -0.5)', Colors.teal),
                  ),
                  Align(
                    alignment: const Alignment(-0.7, 0.6),
                    child: _dot('(-0.7, 0.6)', Colors.orange),
                  ),
                ],
              ),
            ),
          ),
          const Text('Alignment(x, y): x=-1左 x=1右, y=-1上 y=1下', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 20),

          // --- Center ---
          _sectionTitle('3. Center (= Align(alignment: Alignment.center))'),
          Container(
            height: 80,
            color: Colors.green.shade50,
            child: const Center(
              child: Text('Center 居中', style: TextStyle(fontSize: 18)),
            ),
          ),

          const SizedBox(height: 20),

          // --- 相对定位实战 ---
          _sectionTitle('4. 实战: 卡片内的标签定位'),
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('产品名称', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text('产品描述信息', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                // 顶部居中标签
                const Align(
                  alignment: Alignment.topCenter,
                  child: _Badge('推荐', Colors.orange),
                ),
                // 右上角标签
                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: _Badge('NEW', Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
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

class _Dot extends StatelessWidget {
  final String label;
  final Color color;
  const _Dot(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
