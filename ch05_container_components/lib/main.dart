import 'package:flutter/material.dart';
import 'pages/padding_page.dart';
import 'pages/decorated_box_page.dart';
import 'pages/transform_page.dart';
import 'pages/container_page.dart';
import 'pages/clip_page.dart';
import 'pages/fitted_box_page.dart';
import 'pages/scaffold_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第5章 容器类组件',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    PaddingPage(),
    DecoratedBoxPage(),
    TransformPage(),
    ContainerPage(),
    ClipPage(),
    FittedBoxPage(),
    ScaffoldPage(),
  ];

  final List<String> _titles = const [
    '填充 Padding (5.1)',
    '装饰容器 DecoratedBox (5.2)',
    '变换 Transform (5.3)',
    '容器 Container (5.4)',
    '剪裁 Clip (5.5)',
    '空间适配 FittedBox (5.6)',
    '页面骨架 Scaffold (5.7)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.space_bar), label: '填充'),
          NavigationDestination(icon: Icon(Icons.style), label: '装饰'),
          NavigationDestination(icon: Icon(Icons.transform), label: '变换'),
          NavigationDestination(icon: Icon(Icons.widgets), label: '容器'),
          NavigationDestination(icon: Icon(Icons.content_cut), label: '剪裁'),
          NavigationDestination(icon: Icon(Icons.fit_screen), label: '适配'),
          NavigationDestination(icon: Icon(Icons.dashboard), label: '骨架'),
        ],
      ),
    );
  }
}
