import 'package:flutter/material.dart';
import 'pages/pointer_page.dart';
import 'pages/gesture_page.dart';
import 'pages/event_bus_page.dart';
import 'pages/notification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第8章 事件处理与通知',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
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
    PointerPage(),
    GesturePage(),
    EventBusPage(),
    NotificationPage(),
  ];

  final List<String> _titles = const [
    '原始指针事件 (8.1)',
    '手势识别 (8.2 + 8.4)',
    '事件总线 (8.5)',
    '通知 (8.6)',
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
          NavigationDestination(icon: Icon(Icons.touch_app), label: '指针'),
          NavigationDestination(icon: Icon(Icons.gesture), label: '手势'),
          NavigationDestination(icon: Icon(Icons.cable), label: '事件总线'),
          NavigationDestination(icon: Icon(Icons.notifications), label: '通知'),
        ],
      ),
    );
  }
}
