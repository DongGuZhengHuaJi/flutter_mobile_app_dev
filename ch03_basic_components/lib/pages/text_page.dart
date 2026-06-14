import 'package:flutter/material.dart';

/// 3.1 文本及样式
/// 演示: Text, DefaultTextStyle, TextStyle, TextSpan, RichText 等

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 基本文本 ---
          _sectionTitle('1. 基本文本 (Text)'),
          const Text('Hello Flutter! 这是一个普通文本。'),

          const SizedBox(height: 16),

          // --- TextStyle 样式 ---
          _sectionTitle('2. TextStyle 常用属性'),
          Text(
            '颜色 + 字号 + 粗细',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '背景色 + 字母间距 + 装饰线',
            style: TextStyle(
              backgroundColor: Colors.yellow.shade100,
              letterSpacing: 3,
              decoration: TextDecoration.underline,
              decorationColor: Colors.red,
              decorationStyle: TextDecorationStyle.wavy,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '斜体 + 阴影',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 22,
              shadows: const [
                Shadow(color: Colors.grey, offset: Offset(2, 2), blurRadius: 3),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // --- textAlign ---
          _sectionTitle('3. textAlign / textDirection'),
          const Text(
            '这段文字居中对齐，用来测试 textAlign 属性的效果。',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'RTL text direction example.',
            textDirection: TextDirection.rtl,
          ),

          const SizedBox(height: 16),

          // --- maxLines / overflow ---
          _sectionTitle('4. maxLines / overflow'),
          const Text(
            '这是一段很长的文本用来演示 maxLines 和 overflow 的效果。当文本超出指定行数时，会显示省略号代替剩余内容。',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 16),

          // --- TextSpan / RichText ---
          _sectionTitle('5. TextSpan / RichText (富文本)'),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
              children: const [
                TextSpan(text: '这是默认样式，'),
                TextSpan(
                  text: '这是红色加粗',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '，'),
                TextSpan(
                  text: '这是蓝色大号',
                  style: TextStyle(color: Colors.blue, fontSize: 22),
                ),
                TextSpan(text: '，'),
                TextSpan(
                  text: '点击我',
                  style: TextStyle(color: Colors.green, decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // --- DefaultTextStyle ---
          _sectionTitle('6. DefaultTextStyle (默认样式继承)'),
          DefaultTextStyle(
            style: const TextStyle(color: Colors.deepPurple, fontSize: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('这段文字继承了默认样式'),
                Text(
                  '这段覆盖了颜色',
                  style: TextStyle(color: Colors.red.shade400),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // --- textScaleFactor ---
          _sectionTitle('7. textScaler (文本缩放)'),
          Text(
            'scale: 1.0 (默认)',
            textScaler: const TextScaler.linear(1.0),
          ),
          Text(
            'scale: 1.5 (放大)',
            textScaler: const TextScaler.linear(1.5),
          ),
          Text(
            'scale: 0.8 (缩小)',
            textScaler: const TextScaler.linear(0.8),
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
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
