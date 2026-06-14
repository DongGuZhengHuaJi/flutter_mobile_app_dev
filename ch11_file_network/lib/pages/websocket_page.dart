import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

/// 11.5 + 11.6 WebSocket 和 Socket
/// 演示: WebSocket 连接, 收发消息, dart:io Socket

class WebSocketPage extends StatefulWidget {
  const WebSocketPage({super.key});

  @override
  State<WebSocketPage> createState() => _WebSocketPageState();
}

class _WebSocketPageState extends State<WebSocketPage> {
  WebSocketChannel? _channel;
  final _controller = TextEditingController();
  final List<_Message> _messages = [];
  bool _connected = false;
  String _status = '未连接';

  @override
  void dispose() {
    _channel?.sink.close();
    _controller.dispose();
    super.dispose();
  }

  void _connect() {
    try {
      // 使用公开的 echo 测试 WebSocket
      _channel = IOWebSocketChannel.connect(
        Uri.parse('wss://ws.postman-echo.com/raw'),
      );
      setState(() {
        _connected = true;
        _status = '已连接到 wss://ws.postman-echo.com/raw';
        _messages.clear();
      });

      _channel!.stream.listen(
        (data) {
          setState(() {
            _messages.insert(0, _Message('服务器', data.toString(), false));
          });
        },
        onError: (error) {
          setState(() {
            _status = '连接错误: $error';
            _connected = false;
          });
        },
        onDone: () {
          setState(() {
            _status = '连接已关闭';
            _connected = false;
          });
        },
      );
    } catch (e) {
      setState(() => _status = '连接失败: $e');
    }
  }

  void _send() {
    if (_controller.text.isEmpty || _channel == null) return;
    final text = _controller.text;
    _channel!.sink.add(text);
    setState(() {
      _messages.insert(0, _Message('我', text, true));
      _controller.clear();
    });
  }

  void _disconnect() {
    _channel?.sink.close();
    setState(() {
      _connected = false;
      _status = '已断开连接';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('1. WebSocket 连接'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _connected ? Colors.green.shade50 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _connected ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(_status, style: const TextStyle(fontSize: 13))),
                if (_connected)
                  TextButton(onPressed: _disconnect, child: const Text('断开'))
                else
                  ElevatedButton(onPressed: _connect, child: const Text('连接')),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _sectionTitle('2. 发送消息'),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  enabled: _connected,
                  decoration: const InputDecoration(
                    hintText: '输入消息...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _send(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _connected ? _send : null,
                icon: const Icon(Icons.send),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _sectionTitle('3. 消息记录'),
          Container(
            width: double.infinity,
            height: 250,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: _messages.isEmpty
                ? const Center(child: Text('暂无消息', style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, i) {
                      final msg = _messages[i];
                      return Align(
                        alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: msg.isMe ? Colors.cyan.shade100 : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(msg.sender, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: msg.isMe ? Colors.cyan : Colors.grey)),
                              Text(msg.text),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          const SizedBox(height: 20),

          _sectionTitle('WebSocket API'),
          _apiTable(),
        ],
      ),
    );
  }

  Widget _apiTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        _ApiRow('IOWebSocketChannel.connect(uri)', '建立 WebSocket 连接'),
        _ApiRow('channel.sink.add(data)', '发送消息（String 或 List<int>）'),
        _ApiRow('channel.stream.listen(...)', '监听接收的消息'),
        _ApiRow('channel.sink.close()', '关闭连接'),
        _ApiRow('WebSocket.connect(uri)', 'dart:io 原生 WebSocket'),
        _ApiRow('Socket.connect(host, port)', 'dart:io TCP Socket'),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyan)));
  }

}

class _Message {
  final String sender;
  final String text;
  final bool isMe;
  _Message(this.sender, this.text, this.isMe);
}

class _ApiRow extends TableRow {
  _ApiRow(String api, String desc)
      : super(children: [
          Padding(padding: const EdgeInsets.all(8), child: Text(api, style: const TextStyle(fontFamily: 'monospace', fontSize: 11))),
          Padding(padding: const EdgeInsets.all(8), child: Text(desc, style: const TextStyle(fontSize: 11))),
        ]);
}
