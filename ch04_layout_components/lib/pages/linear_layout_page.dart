import 'package:flutter/material.dart';

/// 4.3 线性布局: Row, Column, mainAxisAlignment, crossAxisAlignment

class LinearLayoutPage extends StatelessWidget {
  const LinearLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Row: mainAxisAlignment ---
          _sectionTitle('1. Row - mainAxisAlignment'),
          _coloredContainer(
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _squares(3, Colors.blue),
            ),
            'start',
          ),
          _coloredContainer(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _squares(3, Colors.blue),
            ),
            'center',
          ),
          _coloredContainer(
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _squares(3, Colors.blue),
            ),
            'end',
          ),
          _coloredContainer(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _squares(3, Colors.blue),
            ),
            'spaceBetween',
          ),
          _coloredContainer(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _squares(3, Colors.blue),
            ),
            'spaceAround',
          ),
          _coloredContainer(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _squares(3, Colors.blue),
            ),
            'spaceEvenly',
          ),

          const SizedBox(height: 20),

          // --- Row: crossAxisAlignment ---
          _sectionTitle('2. Row - crossAxisAlignment (垂直交叉轴)'),
          SizedBox(
            height: 100,
            child: _coloredContainer(
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _sizedSquares(3, 40, 60, 50, Colors.teal),
              ),
              'start',
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: _coloredContainer(
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _sizedSquares(3, 40, 60, 50, Colors.teal),
              ),
              'center',
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: _coloredContainer(
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _sizedSquares(3, 40, 60, 50, Colors.teal),
              ),
              'end',
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: _coloredContainer(
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _sizedSquares(3, 40, 60, 50, Colors.teal),
              ),
              'stretch',
            ),
          ),

          const SizedBox(height: 20),

          // --- Column ---
          _sectionTitle('3. Column - mainAxisAlignment (同Row，方向垂直)'),
          SizedBox(
            height: 350,
            child: _coloredContainer(
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _square(50, Colors.orange),
                      _square(50, Colors.orange),
                      _square(50, Colors.orange),
                    ],
                  ),
                  _square(70, Colors.deepPurple),
                  _square(40, Colors.green),
                ],
              ),
              'spaceAround (垂直)',
            ),
          ),

          const SizedBox(height: 20),

          // --- textBaseline 对齐 ---
          _sectionTitle('4. textBaseline (文字基线对齐)'),
          _coloredContainer(
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('ABC', style: TextStyle(fontSize: 24, color: Colors.red.shade300)),
                const SizedBox(width: 8),
                Text('abc', style: TextStyle(fontSize: 16, color: Colors.blue.shade300)),
                const SizedBox(width: 8),
                Text('XYZ', style: TextStyle(fontSize: 32, color: Colors.green.shade300)),
              ],
            ),
            'baseline 对齐',
          ),
        ],
      ),
    );
  }

  Widget _coloredContainer(Widget child, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: child,
          ),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  List<Widget> _squares(int count, Color color) {
    return List.generate(count, (_) => _square(50, color));
  }

  List<Widget> _sizedSquares(int count, double h1, double h2, double h3, Color color) {
    final heights = [h1, h2, h3];
    return List.generate(count, (i) {
      return Container(
        width: 50,
        height: heights[i],
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        child: Center(child: Text('${heights[i].toInt()}', style: const TextStyle(color: Colors.white))),
      );
    });
  }

  Widget _square(double size, Color color) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Center(child: Text('${size.toInt()}', style: const TextStyle(color: Colors.white, fontSize: 11))),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
    );
  }
}
