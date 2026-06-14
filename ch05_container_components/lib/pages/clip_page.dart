import 'dart:math';
import 'package:flutter/material.dart';

/// 5.5 剪裁: ClipRect, ClipRRect, ClipOval, ClipPath, ClipPath.shape

class ClipPage extends StatelessWidget {
  const ClipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('1. ClipOval (圆形剪裁)'),
          Row(
            children: [
              _clipDemo(
                ClipOval(child: _contentBox(Colors.red, size: 80)),
                'ClipOval\n正方形→圆',
              ),
              const SizedBox(width: 12),
              _clipDemo(
                ClipOval(child: _contentBox(Colors.blue, size: 80, w: 120)),
                'ClipOval\n长方形→椭圆',
              ),
            ],
          ),

          const SizedBox(height: 16),

          _sectionTitle('2. ClipRRect (圆角矩形剪裁)'),
          Row(
            children: [
              _clipDemo(
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _contentBox(Colors.teal, size: 80),
                ),
                'circular(16)',
              ),
              const SizedBox(width: 12),
              _clipDemo(
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  child: _contentBox(Colors.orange, size: 80),
                ),
                '对角圆角',
              ),
            ],
          ),

          const SizedBox(height: 16),

          _sectionTitle('3. ClipRect (矩形剪裁) + Align'),
          Container(
            height: 80,
            color: Colors.grey.shade100,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: 0.6,
                heightFactor: 0.6,
                child: _contentBox(Colors.deepPurple, size: 120),
              ),
            ),
          ),
          const Text('ClipRect + Align(widthFactor) — 只显示子元素左上角60%', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 16),

          _sectionTitle('4. ClipPath (路径剪裁)'),
          Row(
            children: [
              _clipDemo(
                ClipPath(
                  clipper: _StarClipper(),
                  child: _contentBox(Colors.amber),
                ),
                '星形',
              ),
              const SizedBox(width: 12),
              _clipDemo(
                ClipPath(
                  clipper: _TriangleClipper(),
                  child: _contentBox(Colors.indigo),
                ),
                '三角形',
              ),
              const SizedBox(width: 12),
              _clipDemo(
                ClipPath.shape(
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: _contentBox(Colors.cyan),
                ),
                '切角',
              ),
            ],
          ),

          const SizedBox(height: 20),

          _sectionTitle('5. 实战: 头像裁切对比'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [const CircleAvatar(radius: 36, backgroundColor: Colors.teal, child: Icon(Icons.person, size: 40, color: Colors.white)), const SizedBox(height: 4), const Text('CircleAvatar', style: TextStyle(fontSize: 11))]),
              Column(children: [ClipRRect(borderRadius: BorderRadius.circular(8), child: Container(width: 72, height: 72, color: Colors.teal, alignment: Alignment.center, child: const Icon(Icons.person, size: 40, color: Colors.white))), const SizedBox(height: 4), const Text('圆角方形', style: TextStyle(fontSize: 11))]),
              Column(children: [ClipOval(child: Container(width: 72, height: 72, color: Colors.teal, alignment: Alignment.center, child: const Icon(Icons.person, size: 40, color: Colors.white))), const SizedBox(height: 4), const Text('ClipOval', style: TextStyle(fontSize: 11))]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contentBox(Color color, {double size = 80, double? w}) {
    return Container(
      width: w ?? size,
      height: size,
      color: color,
      alignment: Alignment.center,
      child: const Text('内容', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _clipDemo(Widget child, String label) {
    return Column(
      children: [
        child,
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange)));
  }
}

/// 自定义星形裁剪路径
class _StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final outerR = size.width / 2;
    final innerR = outerR * 0.4;
    const points = 5;
    for (int i = 0; i < points * 2; i++) {
      final r = i.isEven ? outerR : innerR;
      final angle = (i / (points * 2)) * 2 * 3.1415926 - 3.1415926 / 2;
      final x = centerX + r * cos(angle);
      final y = centerY + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// 自定义三角形裁剪路径
class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
