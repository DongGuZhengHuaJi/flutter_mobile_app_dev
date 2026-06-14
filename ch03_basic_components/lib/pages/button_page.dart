import 'package:flutter/material.dart';

/// 3.2 按钮
/// 演示: ElevatedButton, TextButton, OutlinedButton, IconButton,
///       FloatingActionButton, 带图标的按钮, 按钮样式定制等

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- ElevatedButton ---
          _sectionTitle('1. ElevatedButton (凸起按钮)'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: () => _showSnackBar(context, 'ElevatedButton 点击'),
                child: const Text('基本'),
              ),
              ElevatedButton.icon(
                onPressed: () => _showSnackBar(context, '带图标的 ElevatedButton'),
                icon: const Icon(Icons.star),
                label: const Text('带图标'),
              ),
              ElevatedButton(
                onPressed: null,
                child: const Text('禁用状态'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('自定义样式'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- TextButton ---
          _sectionTitle('2. TextButton (文本按钮)'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              TextButton(
                onPressed: () => _showSnackBar(context, 'TextButton 点击'),
                child: const Text('基本'),
              ),
              TextButton.icon(
                onPressed: () => _showSnackBar(context, '带图标的 TextButton'),
                icon: const Icon(Icons.favorite),
                label: const Text('收藏'),
              ),
              TextButton(
                onPressed: null,
                child: const Text('禁用'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- OutlinedButton ---
          _sectionTitle('3. OutlinedButton (描边按钮)'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OutlinedButton(
                onPressed: () => _showSnackBar(context, 'OutlinedButton 点击'),
                child: const Text('基本'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text('发送'),
              ),
              OutlinedButton(
                onPressed: null,
                child: const Text('禁用'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- IconButton ---
          _sectionTitle('4. IconButton (图标按钮)'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              IconButton(
                onPressed: () => _showSnackBar(context, 'search'),
                icon: const Icon(Icons.search),
                tooltip: '搜索',
              ),
              IconButton(
                onPressed: () => _showSnackBar(context, 'settings'),
                icon: const Icon(Icons.settings),
                color: Colors.blue,
                iconSize: 32,
              ),
              IconButton(
                onPressed: null,
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.person),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- FloatingActionButton ---
          _sectionTitle('5. FloatingActionButton (浮动按钮)'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FloatingActionButton(
                onPressed: () => _showSnackBar(context, 'FAB 点击'),
                child: const Icon(Icons.add),
              ),
              FloatingActionButton.small(
                onPressed: () {},
                child: const Icon(Icons.edit),
              ),
              FloatingActionButton.large(
                onPressed: () {},
                child: const Icon(Icons.play_arrow),
              ),
              FloatingActionButton.extended(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text('分享'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- 按钮组 ---
          _sectionTitle('6. SegmentedButton (分段按钮)'),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('日'), icon: Icon(Icons.wb_sunny)),
              ButtonSegment(value: 1, label: Text('周'), icon: Icon(Icons.view_week)),
              ButtonSegment(value: 2, label: Text('月'), icon: Icon(Icons.calendar_month)),
            ],
            selected: const {1},
            onSelectionChanged: (_) {},
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$message 已触发'), duration: const Duration(seconds: 1)),
    );
  }
}
