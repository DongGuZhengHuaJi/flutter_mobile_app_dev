import 'package:flutter/material.dart';

/// 4.8 LayoutBuilder — 根据父容器约束动态构建布局

class LayoutBuilderPage extends StatelessWidget {
  const LayoutBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- LayoutBuilder 基础 ---
          _sectionTitle('1. LayoutBuilder 基础 — 响应式宽度'),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                padding: const EdgeInsets.all(12),
                color: Colors.blue.shade50,
                child: Column(
                  children: [
                    Text('maxWidth: ${constraints.maxWidth.toStringAsFixed(0)}'),
                    Text('maxHeight: ${constraints.maxHeight.toStringAsFixed(0)}'),
                    const Text('minWidth: 0 (无限制)'),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // --- 根据宽度切换布局 ---
          _sectionTitle('2. 响应式布局 — 宽屏/窄屏切换'),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 400) {
                // 宽屏: 横向排列
                return Row(
                  children: [
                    Expanded(child: _infoCard(Icons.person, '用户', '3,456', Colors.blue)),
                    const SizedBox(width: 8),
                    Expanded(child: _infoCard(Icons.shopping_cart, '订单', '1,234', Colors.green)),
                    const SizedBox(width: 8),
                    Expanded(child: _infoCard(Icons.star, '收藏', '891', Colors.orange)),
                  ],
                );
              } else {
                // 窄屏: 纵向排列
                return Column(
                  children: [
                    _infoCard(Icons.person, '用户', '3,456', Colors.blue),
                    const SizedBox(height: 8),
                    _infoCard(Icons.shopping_cart, '订单', '1,234', Colors.green),
                    const SizedBox(height: 8),
                    _infoCard(Icons.star, '收藏', '891', Colors.orange),
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 20),

          // --- ConstrainedBox ---
          _sectionTitle('3. ConstrainedBox — 给子元素施加约束'),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 50,
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('按钮被拉伸到全宽'),
            ),
          ),

          const SizedBox(height: 12),

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 150,
            ),
            child: const Text(
              '这段文本被限制最大宽度150，超出部分会自动换行显示。',
            ),
          ),

          const SizedBox(height: 20),

          // --- UnconstrainedBox ---
          _sectionTitle('4. UnconstrainedBox — 解除父约束'),
          Container(
            color: Colors.grey.shade200,
            height: 60,
            child: UnconstrainedBox(
              child: Container(
                width: 80,
                height: 100,
                color: Colors.red.shade300,
                alignment: Alignment.center,
                child: const Text('突破60高度', style: TextStyle(color: Colors.white, fontSize: 11)),
              ),
            ),
          ),
          const Text('父容器限制高度60，UnconstrainedBox 解除后子元素可突破', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 20),

          // --- AspectRatio ---
          _sectionTitle('5. AspectRatio — 固定宽高比'),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(color: Colors.teal.shade200, alignment: Alignment.center, child: const Text('16:9', style: TextStyle(fontSize: 20, color: Colors.white))),
          ),

          const SizedBox(height: 20),

          // --- FractionallySizedBox ---
          _sectionTitle('6. FractionallySizedBox — 按比例填充'),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 80,
                  color: Colors.grey.shade100,
                  child: FractionallySizedBox(
                    widthFactor: 0.6,
                    heightFactor: 0.6,
                    child: Container(color: Colors.deepPurple.shade300, alignment: Alignment.center, child: const Text('60%', style: TextStyle(color: Colors.white))),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 80,
                  color: Colors.grey.shade100,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.9,
                    child: Container(color: Colors.orange.shade300, alignment: Alignment.center, child: const Text('90%', style: TextStyle(color: Colors.white))),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // --- LimitedBox ---
          _sectionTitle('7. LimitedBox — 限制默认最大尺寸'),
          LimitedBox(
            maxWidth: 200,
            child: Container(color: Colors.indigo.shade100, padding: const EdgeInsets.all(12), child: const Text('LimitedBox maxWidth: 200')),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withAlpha(30), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)), Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color))],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
    );
  }
}
