import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// 11.2 + 11.3 + 11.4 HTTP 请求
/// 演示: HttpClient, http 包 GET/POST, 文件下载

class HttpPage extends StatefulWidget {
  const HttpPage({super.key});

  @override
  State<HttpPage> createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  String _result = '';
  bool _loading = false;

  Future<void> _getRequest() async {
    setState(() {
      _loading = true;
      _result = '';
    });
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _result = 'GET /posts/1\n状态码: ${response.statusCode}\n\n${const JsonEncoder.withIndent('  ').convert(data)}';
        });
      } else {
        setState(() => _result = '请求失败: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => _result = '网络错误: $e\n\n(请确保网络连接正常)');
    }
    setState(() => _loading = false);
  }

  Future<void> _postRequest() async {
    setState(() {
      _loading = true;
      _result = '';
    });
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': 'Flutter POST 测试',
          'body': '这是通过 http 包发送的 POST 请求内容',
          'userId': 1,
        }),
      );
      setState(() {
        _result = 'POST /posts\n状态码: ${response.statusCode}\n\n${const JsonEncoder.withIndent('  ').convert(json.decode(response.body))}';
      });
    } catch (e) {
      setState(() => _result = '网络错误: $e');
    }
    setState(() => _loading = false);
  }

  Future<void> _httpClientGet() async {
    setState(() {
      _loading = true;
      _result = '';
    });
    try {
      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      client.close();
      setState(() {
        _result = 'HttpClient GET /users/1\n状态码: ${response.statusCode}\n\n${const JsonEncoder.withIndent('  ').convert(json.decode(body))}';
      });
    } catch (e) {
      setState(() => _result = '网络错误: $e');
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('1. http 包 (推荐)'),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _loading ? null : _getRequest,
                  icon: const Icon(Icons.download),
                  label: const Text('GET 请求'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _loading ? null : _postRequest,
                  icon: const Icon(Icons.upload),
                  label: const Text('POST 请求'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _sectionTitle('2. HttpClient (dart:io 原生)'),
          ElevatedButton.icon(
            onPressed: _loading ? null : _httpClientGet,
            icon: const Icon(Icons.code),
            label: const Text('HttpClient GET 请求'),
          ),

          const SizedBox(height: 16),

          if (_loading)
            const Center(child: LinearProgressIndicator())
          else if (_result.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(8)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(_result, style: const TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', fontSize: 11)),
              ),
            ),

          const SizedBox(height: 20),

          _sectionTitle('HTTP 方法对比'),
          _apiTable(),
        ],
      ),
    );
  }

  Widget _apiTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {0: FlexColumnWidth(1.5), 1: FlexColumnWidth(2)},
      children: [
        _ApiRow('http.get(uri)', 'GET 请求，返回 Response'),
        _ApiRow('http.post(uri, body:)', 'POST 请求，body 为 JSON 字符串'),
        _ApiRow('http.put(uri, body:)', 'PUT 请求（更新资源）'),
        _ApiRow('http.delete(uri)', 'DELETE 请求（删除资源）'),
        _ApiRow('HttpClient().getUrl()', 'dart:io 原生 HTTP 客户端'),
        _ApiRow('Response.statusCode', 'HTTP 状态码 (200=成功)'),
        _ApiRow('Response.body', '响应体 (String)'),
        _ApiRow('json.decode(str)', 'JSON 字符串 → Map/List'),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyan)));
  }
}

class _ApiRow extends TableRow {
  _ApiRow(String api, String desc)
      : super(children: [
          Padding(padding: const EdgeInsets.all(8), child: Text(api, style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
          Padding(padding: const EdgeInsets.all(8), child: Text(desc, style: const TextStyle(fontSize: 12))),
        ]);
}
