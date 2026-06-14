import 'dart:async';
import 'package:flutter/material.dart';

/// 8.5 事件总线 (EventBus)
/// 演示: 自定义 EventBus, Stream 订阅与广播, 跨组件通信

// ============== 事件定义 ==============
enum CartAction { add, remove }

class CartEvent {
  final String itemName;
  final CartAction action;

  const CartEvent(this.itemName, this.action);
}

// ============== EventBus ==============
class EventBus {
  static final EventBus _instance = EventBus._();
  factory EventBus() => _instance;
  EventBus._();

  final StreamController<CartEvent> _controller = StreamController<CartEvent>.broadcast();

  void fire(CartEvent event) {
    _controller.add(event);
  }

  Stream<CartEvent> get onCartEvent => _controller.stream;
}

// ============== 页面 ==============
class EventBusPage extends StatefulWidget {
  const EventBusPage({super.key});

  @override
  State<EventBusPage> createState() => _EventBusPageState();
}

class _EventBusPageState extends State<EventBusPage> {
  final EventBus _bus = EventBus();
  final List<String> _cartItems = [];
  final List<String> _logs = [];
  StreamSubscription<CartEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _bus.onCartEvent.listen((event) {
      setState(() {
        final symbol = event.action == CartAction.add ? '+' : '-';
        _logs.insert(0, '[$symbol] ${event.itemName}');
        if (event.action == CartAction.add) {
          _cartItems.add(event.itemName);
        } else {
          _cartItems.remove(event.itemName);
        }
        if (_logs.length > 20) _logs.removeLast();
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('EventBus 模式 — 跨组件解耦通信'),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('EventBus 三要素:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                SizedBox(height: 4),
                Text('① 事件类 — 封装事件数据'),
                Text('② 事件总线 — 单例 StreamController.broadcast()'),
                Text('③ 订阅者 — 监听 stream 并处理事件'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 商品列表
          _sectionTitle('商品列表 (事件发布者)'),
          Row(
            children: [
              _productCard('iPhone', '5999'),
              const SizedBox(width: 12),
              _productCard('MacBook', '12999'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _productCard('AirPods', '1299'),
              const SizedBox(width: 12),
              _productCard('iPad', '4499'),
            ],
          ),

          const SizedBox(height: 16),

          // 购物车状态
          _sectionTitle('购物车 (事件订阅者)'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.shopping_cart, color: Colors.amber),
                    const SizedBox(width: 8),
                    Text('${_cartItems.length} 件商品', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                if (_cartItems.isEmpty)
                  const Padding(padding: EdgeInsets.all(8), child: Text('购物车为空', style: TextStyle(color: Colors.grey)))
                else
                  ..._cartItems.map((item) => ListTile(
                        dense: true,
                        title: Text(item),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () => _bus.fire(CartEvent(item, CartAction.remove)),
                        ),
                      )),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 事件日志
          _sectionTitle('事件日志'),
          Container(
            width: double.infinity,
            height: 140,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(8)),
            child: ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, i) => Text(
                _logs[i],
                style: TextStyle(color: _logs[i].startsWith('+') ? Colors.greenAccent : Colors.redAccent, fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(String name, String price) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(Icons.devices, size: 36, color: Colors.indigo.shade300),
              const SizedBox(height: 8),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('¥$price', style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => EventBus().fire(CartEvent(name, CartAction.add)),
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 32)),
                child: const Text('加入购物车', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)));
  }
}
