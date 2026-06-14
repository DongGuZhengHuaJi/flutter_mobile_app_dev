# 第11章：文件操作与网络请求

基于《Flutter实战·第二版》第11章内容，涵盖文件读写、HTTP 网络请求、WebSocket 通信和 JSON 序列化。

## 章节知识图谱

```
文件操作与网络请求 (ch11)
├── 11.1 文件操作 ────── File, Directory, readAsString, writeAsString, path_provider
├── 11.2 HttpClient ──── dart:io HttpClient 原生 HTTP 请求
├── 11.3 dio / http ──── http 包, GET/POST/PUT/DELETE
├── 11.5 WebSocket ───── web_socket_channel, IOWebSocketChannel, 收发消息
├── 11.6 Socket API ──── dart:io Socket, TCP 连接
└── 11.7 JSON → Model ── json.decode, fromJson 工厂构造, toJson, 嵌套解析
```

## 项目结构

```
ch11_file_network/
├── lib/
│   ├── main.dart                   # 应用入口 + 底部导航
│   └── pages/
│       ├── file_page.dart          # 11.1 文件操作
│       ├── http_page.dart          # 11.2+11.3+11.4 HTTP 请求
│       ├── websocket_page.dart     # 11.5+11.6 WebSocket
│       └── json_page.dart          # 11.7 JSON 转 Model
├── pubspec.yaml                    # 依赖: http, web_socket_channel, path_provider
└── README.md
```

## 核心知识点

### 11.1 文件操作

| API | 说明 |
|-----|------|
| `File(path)` | 文件引用 |
| `.readAsString()` | 异步读取文本（返回 Future\<String\>） |
| `.writeAsString(str)` | 异步写入文本 |
| `.readAsBytes()` | 异步读取字节 |
| `.writeAsBytes(bytes)` | 异步写入字节 |
| `.existsSync()` | 同步检查是否存在 |
| `.delete()` | 删除文件 |
| `Directory(path)` | 目录引用 |
| `.listSync()` | 同步列出目录内容 |
| `.createSync()` | 同步创建目录 |
| `getApplicationDocumentsDirectory()` | 获取应用文档目录（path_provider） |

**文件读写示例 (file_page.dart:52-56):**
```dart
final file = File('$_appDir/note.txt');
await file.writeAsString('Hello Flutter!');
final content = await file.readAsString();
```

### 11.2 + 11.3 HTTP 请求

**http 包 (推荐):**

| API | 说明 |
|-----|------|
| `http.get(uri)` | GET 请求 |
| `http.post(uri, body:, headers:)` | POST 请求 |
| `http.put(uri, body:)` | PUT 请求 |
| `http.delete(uri)` | DELETE 请求 |
| `Response.statusCode` | HTTP 状态码 |
| `Response.body` | 响应体（String） |

**关键代码 (http_page.dart:25-37) — GET 请求:**
```dart
final response = await http.get(
  Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
);
if (response.statusCode == 200) {
  final data = json.decode(response.body);
  print(data['title']);
}
```

**关键代码 (http_page.dart:43-56) — POST 请求:**
```dart
final response = await http.post(
  Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  headers: {'Content-Type': 'application/json'},
  body: json.encode({
    'title': 'Flutter POST 测试',
    'body': '内容',
    'userId': 1,
  }),
);
```

**dart:io HttpClient (原生):**
```dart
final client = HttpClient();
final request = await client.getUrl(Uri.parse('...'));
final response = await request.close();
final body = await response.transform(utf8.decoder).join();
client.close();
```

### 11.5 + 11.6 WebSocket

| API | 说明 |
|-----|------|
| `IOWebSocketChannel.connect(uri)` | 建立 WebSocket 连接 |
| `channel.sink.add(data)` | 发送消息 |
| `channel.stream.listen(...)` | 接收消息 |
| `channel.sink.close()` | 关闭连接 |

**WebSocket 通信模式 (websocket_page.dart:37-65):**
```dart
final channel = IOWebSocketChannel.connect(
  Uri.parse('wss://echo.example.com/ws'),
);

// 发送
channel.sink.add('Hello');

// 接收
channel.stream.listen(
  (data) => print('收到: $data'),
  onError: (error) => print('错误: $error'),
  onDone: () => print('连接关闭'),
);

// 断开
channel.sink.close();
```

### 11.7 JSON 转 Dart Model

**核心模式 — 三层嵌套解析 (json_page.dart:10-88):**

```dart
class User {
  final int id;
  final String name;
  final String email;
  final Address address;      // 嵌套对象
  final List<String> tags;     // 列表

  User({required this.id, required this.name, ...});

  // fromJson: JSON → Model (工厂构造函数)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      address: Address.fromJson(json['address']),     // 递归解析
      tags: (json['tags'] as List).map((e) => e as String).toList(),
    );
  }

  // toJson: Model → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address.toJson(),
      'tags': tags,
    };
  }
}

// 使用
final user = User.fromJson(json.decode(jsonString));
final jsonString = json.encode(user.toJson());
```

**解析规则总结:**

| JSON 类型 | Dart 转换 |
|-----------|----------|
| `"string"` | `json['key'] as String` |
| `123` | `json['key'] as int` |
| `1.5` | `(json['key'] as num).toDouble()` |
| `true/false` | `json['key'] as bool` |
| `{...}` (对象) | `ChildModel.fromJson(json['key'])` |
| `[...]` (数组) | `(json['key'] as List).map((e) => ...)` |

## 运行方式

```bash
cd ch11_file_network
flutter pub get
flutter run
```

## 关键设计要点

1. **异步无处不在**: 文件/网络操作都是 `Future`，必须用 `async/await`
2. **错误处理**: 网络请求务必 try-catch，处理超时和网络不可用
3. **fromJson/toJson 模式**: 每个 Model 类独立实现，支持嵌套递归
4. **WebSocket 生命周期**: 及时关闭连接，监听 stream 的 onError/onDone
5. **path_provider**: 不同平台的文件存储路径不同，使用插件统一获取
6. **JSON 序列化工具**: 大型项目推荐 [json_serializable](https://pub.dev/packages/json_serializable) 自动生成代码
