import 'package:flutter/material.dart';
import 'pages/linear_layout_page.dart';
import 'pages/flex_page.dart';
import 'pages/wrap_flow_page.dart';
import 'pages/stack_page.dart';
import 'pages/align_page.dart';
import 'pages/layout_builder_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第4章 布局类组件',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
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
    LinearLayoutPage(),
    FlexPage(),
    WrapFlowPage(),
    StackPage(),
    AlignPage(),
    LayoutBuilderPage(),
  ];

  final List<String> _titles = const [
    '线性布局 (4.3)',
    '弹性布局 (4.4)',
    '流式布局 (4.5)',
    '层叠布局 (4.6)',
    '对齐与相对定位 (4.7)',
    'LayoutBuilder (4.8)',
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
        destinations: const [
          NavigationDestination(icon: Icon(Icons.view_agenda), label: '线性'),
          NavigationDestination(icon: Icon(Icons.space_bar), label: '弹性'),
          NavigationDestination(icon: Icon(Icons.wrap_text), label: '流式'),
          NavigationDestination(icon: Icon(Icons.layers), label: '层叠'),
          NavigationDestination(icon: Icon(Icons.align_horizontal_center), label: '对齐'),
          NavigationDestination(icon: Icon(Icons.build), label: 'Builder'),
        ],
      ),
    );
  }
}
