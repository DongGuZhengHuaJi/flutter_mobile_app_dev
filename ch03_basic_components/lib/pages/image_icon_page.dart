import 'dart:typed_data';
import 'package:flutter/material.dart';

// 1x1 透明 PNG
final Uint8List kTransparentImage = Uint8List.fromList(const [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x00, 0x00, 0x02,
  0x00, 0x01, 0xE2, 0x21, 0xBC, 0x33, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
  0x60, 0x82,
]);

/// 3.3 图片及ICON
/// 演示: Image.asset, Image.network, Image.file, Icon, ImageIcon, FadeInImage

class ImageIconPage extends StatelessWidget {
  const ImageIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 网络图片 ---
          _sectionTitle('1. Image.network (网络图片)'),
          const Center(
            child: Image(
              image: NetworkImage('https://picsum.photos/300/150'),
              width: 300,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          const Text('fit: BoxFit.cover — 等比缩放填满，超出裁剪'),

          const SizedBox(height: 16),

          // --- BoxFit 对比 ---
          _sectionTitle('2. BoxFit 效果对比'),
          SizedBox(
            height: 480,
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.3,
              physics: const NeverScrollableScrollPhysics(),
              children: BoxFit.values.map((fit) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        child: Image.network(
                          'https://picsum.photos/100/70',
                          fit: fit,
                        ),
                      ),
                    ),
                    Text(fit.name, style: const TextStyle(fontSize: 10)),
                  ],
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // --- 占位图 ---
          _sectionTitle('3. FadeInImage (淡入占位图)'),
          Center(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: 'https://picsum.photos/300/150',
              width: 300,
              height: 150,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 300,
                  height: 150,
                  color: Colors.grey.shade200,
                  child: const Center(child: Text('图片加载失败')),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // --- 颜色混合 ---
          _sectionTitle('4. color / colorBlendMode (颜色混合)'),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.network('https://picsum.photos/80/80', color: Colors.red, colorBlendMode: BlendMode.multiply),
                    const SizedBox(height: 4),
                    const Text('multiply', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Image.network('https://picsum.photos/80/80', color: Colors.blue, colorBlendMode: BlendMode.screen),
                    const SizedBox(height: 4),
                    const Text('screen', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Image.network('https://picsum.photos/80/80', color: Colors.green, colorBlendMode: BlendMode.overlay),
                    const SizedBox(height: 4),
                    const Text('overlay', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // --- Icon 图标 ---
          _sectionTitle('5. Icon (Material Icons)'),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _iconItem(Icons.home, 'home'),
              _iconItem(Icons.favorite, 'favorite', color: Colors.red),
              _iconItem(Icons.star, 'star', color: Colors.amber),
              _iconItem(Icons.face, 'face', color: Colors.deepPurple),
              _iconItem(Icons.cloud, 'cloud', color: Colors.blue, size: 40),
              _iconItem(Icons.thumb_up, 'thumb_up'),
            ],
          ),

          const SizedBox(height: 16),

          // --- ImageIcon ---
          _sectionTitle('6. ImageIcon (图片图标)'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.ac_unit, size: 40, color: Colors.lightBlue),
              Icon(Icons.whatshot, size: 40, color: Colors.deepOrange),
              Icon(Icons.eco, size: 40, color: Colors.green),
              Icon(Icons.wb_sunny, size: 40, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconItem(IconData icon, String label, {Color? color, double size = 28}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: size, color: color),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
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
}
