import 'package:flutter/material.dart';

/// 3.6 进度指示器
/// 演示: LinearProgressIndicator, CircularProgressIndicator, 自定义进度

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> with SingleTickerProviderStateMixin {
  double _progress = 0.3;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _simulateProgress() async {
    for (double i = 0; i <= 1.0; i += 0.05) {
      await Future.delayed(const Duration(milliseconds: 80));
      setState(() => _progress = i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- LinearProgressIndicator ---
          _sectionTitle('1. 线性进度条 (LinearProgressIndicator)'),
          const Text('确定进度 (determinate):'),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: _progress),
          const SizedBox(height: 8),
          Text('当前进度: ${(_progress * 100).toStringAsFixed(0)}%'),
          const SizedBox(height: 12),
          const Text('不确定进度 (indeterminate):'),
          const SizedBox(height: 4),
          const LinearProgressIndicator(),

          const SizedBox(height: 16),

          // --- CircularProgressIndicator ---
          _sectionTitle('2. 圆形进度指示器 (CircularProgressIndicator)'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CircularProgressIndicator(value: _progress),
                  const SizedBox(height: 8),
                  Text('${(_progress * 100).toStringAsFixed(0)}%'),
                ],
              ),
              const Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 8),
                  Text('加载中...'),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- 自定义颜色/粗细 ---
          _sectionTitle('3. 自定义样式'),
          const LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.grey,
            color: Colors.green,
            minHeight: 10,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  value: 0.6,
                  strokeWidth: 5,
                  color: Colors.orange,
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 8,
                  color: Colors.purple,
                  backgroundColor: Colors.purple.shade100,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- 控制按钮 ---
          _sectionTitle('4. 模拟进度'),
          ElevatedButton(
            onPressed: _simulateProgress,
            child: const Text('开始加载'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
      ),
    );
  }
}
