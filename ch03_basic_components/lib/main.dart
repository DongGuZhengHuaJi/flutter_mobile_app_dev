import 'package:flutter/material.dart';
import 'pages/text_page.dart';
import 'pages/button_page.dart';
import 'pages/image_icon_page.dart';
import 'pages/switch_checkbox_page.dart';
import 'pages/form_page.dart';
import 'pages/progress_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第3章 基础组件',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
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
    TextPage(),
    ButtonPage(),
    ImageIconPage(),
    SwitchCheckboxPage(),
    FormPage(),
    ProgressPage(),
  ];

  final List<String> _titles = const [
    '文本及样式 (3.1)',
    '按钮 (3.2)',
    '图片及ICON (3.3)',
    '单选开关和复选框 (3.4)',
    '输入框及表单 (3.5)',
    '进度指示器 (3.6)',
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
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.text_fields), label: '文本'),
          NavigationDestination(icon: Icon(Icons.smart_button), label: '按钮'),
          NavigationDestination(icon: Icon(Icons.image), label: '图片'),
          NavigationDestination(icon: Icon(Icons.check_box), label: '选择'),
          NavigationDestination(icon: Icon(Icons.edit_note), label: '表单'),
          NavigationDestination(icon: Icon(Icons.downloading), label: '进度'),
        ],
      ),
    );
  }
}
