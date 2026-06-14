import 'package:flutter/material.dart';
import 'pages/file_page.dart';
import 'pages/http_page.dart';
import 'pages/websocket_page.dart';
import 'pages/json_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第11章 文件操作与网络请求',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.cyan,
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
    FilePage(),
    HttpPage(),
    WebSocketPage(),
    JsonPage(),
  ];

  final List<String> _titles = const [
    '文件操作 (11.1)',
    'HTTP 请求 (11.2+11.3+11.4)',
    'WebSocket (11.5+11.6)',
    'JSON 转 Model (11.7)',
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
          NavigationDestination(icon: Icon(Icons.folder), label: '文件'),
          NavigationDestination(icon: Icon(Icons.http), label: 'HTTP'),
          NavigationDestination(icon: Icon(Icons.language), label: 'WebSocket'),
          NavigationDestination(icon: Icon(Icons.data_object), label: 'JSON'),
        ],
      ),
    );
  }
}
