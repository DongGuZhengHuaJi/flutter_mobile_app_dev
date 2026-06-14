import 'dart:convert';
import 'package:flutter/material.dart';

/// 11.7 JSON 转 Dart Model 类
/// 演示: json.decode, fromJson/toJson, 工厂构造函数, 嵌套 Model, 列表解析

// ============== Model 类定义 ==============
class User {
  final int id;
  final String name;
  final String email;
  final Address address;
  final List<String> tags;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.tags,
  });

  /// 从 JSON Map 构造 User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  /// 转换为 JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address.toJson(),
      'tags': tags,
    };
  }

  @override
  String toString() => 'User(id:$id, name:$name)';
}

class Address {
  final String street;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({required this.street, required this.city, required this.zipcode, required this.geo});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      city: json['city'] as String,
      zipcode: json['zipcode'] as String,
      geo: Geo.fromJson(json['geo'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {'street': street, 'city': city, 'zipcode': zipcode, 'geo': geo.toJson()};
}

class Geo {
  final double lat;
  final double lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

// ============== 页面 ==============
class JsonPage extends StatefulWidget {
  const JsonPage({super.key});

  @override
  State<JsonPage> createState() => _JsonPageState();
}

class _JsonPageState extends State<JsonPage> {
  String _jsonInput = '';
  User? _parsedUser;
  String _serializedJson = '';

  void _parseJson() {
    if (_jsonInput.isEmpty) {
      // 使用示例 JSON
      _jsonInput = _sampleJson;
    }
    try {
      final map = json.decode(_jsonInput) as Map<String, dynamic>;
      final user = User.fromJson(map);
      setState(() {
        _parsedUser = user;
        _serializedJson = const JsonEncoder.withIndent('  ').convert(user.toJson());
      });
    } catch (e) {
      setState(() {
        _parsedUser = null;
        _serializedJson = '解析失败: $e';
      });
    }
  }

  String get _sampleJson => '''
{
  "id": 1,
  "name": "张三",
  "email": "zhangsan@example.com",
  "address": {
    "street": "科技路 188 号",
    "city": "北京",
    "zipcode": "100000",
    "geo": {
      "lat": 39.9042,
      "lng": 116.4074
    }
  },
  "tags": ["Flutter", "Dart", "Mobile"]
}''';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('1. JSON 原始数据'),
          Container(
            width: double.infinity,
            height: 220,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: Text(
                _jsonInput.isEmpty ? _sampleJson : _jsonInput,
                style: const TextStyle(color: Colors.amberAccent, fontFamily: 'monospace', fontSize: 11),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _parseJson,
                icon: const Icon(Icons.play_arrow),
                label: const Text('解析 JSON → Model'),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () => setState(() {
                  _jsonInput = '';
                  _parsedUser = null;
                  _serializedJson = '';
                }),
                icon: const Icon(Icons.refresh),
                label: const Text('重置'),
              ),
            ],
          ),

          if (_parsedUser != null) ...[
            const SizedBox(height: 16),

            _sectionTitle('2. Model 对象 (fromJson 结果)'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _modelField('id', _parsedUser!.id.toString()),
                  _modelField('name', _parsedUser!.name),
                  _modelField('email', _parsedUser!.email),
                  const Divider(),
                  const Text('address (嵌套对象):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  _modelField('  street', _parsedUser!.address.street),
                  _modelField('  city', _parsedUser!.address.city),
                  _modelField('  geo.lat', _parsedUser!.address.geo.lat.toString()),
                  _modelField('  geo.lng', _parsedUser!.address.geo.lng.toString()),
                  const Divider(),
                  _modelField('tags (List)', _parsedUser!.tags.join(', ')),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _sectionTitle('3. toJson 序列化'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(_serializedJson,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
            ),
          ],

          const SizedBox(height: 20),

          _sectionTitle('fromJson / toJson 模式'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.cyan.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1. 工厂构造函数 fromJson(Map) → Model'),
                Text('2. 实例方法 toJson() → Map'),
                Text('3. 嵌套对象: 递归调用子 Model.fromJson()'),
                Text('4. List 解析: .map((e) => e as Type).toList()'),
                Text('5. 类型安全: 使用 as 显式转换'),
                Text('6. num → double: .toDouble() 兼容 int/double'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _modelField(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$key: ', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)),
          Expanded(child: Text(value, style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyan)));
  }
}
