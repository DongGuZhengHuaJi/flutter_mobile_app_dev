import 'package:flutter/material.dart';

/// 8.6 通知 (Notification)
/// 演示: NotificationListener, 自定义 Notification, ScrollNotification

// ============== 自定义通知 ==============
class MyNotification extends Notification {
  final String message;
  final int value;

  MyNotification(this.message, this.value);
}

// ============== 子组件 ==============
class _SendNotificationWidget extends StatelessWidget {
  const _SendNotificationWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => MyNotification('普通消息', 1).dispatch(context),
          icon: const Icon(Icons.send),
          label: const Text('发送普通通知'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => MyNotification('警告消息', 99).dispatch(context),
          icon: const Icon(Icons.warning),
          label: const Text('发送警告通知'),
        ),
      ],
    );
  }
}

// ============== 页面 ==============
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<String> _notificationLog = [];
  double _scrollProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Notification — 自下而上的通知机制'),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              '与 EventBus 不同，Notification 沿 Widget 树自下而上冒泡传递。'
              '祖先节点通过 NotificationListener 拦截。',
              style: TextStyle(color: Colors.indigo),
            ),
          ),

          const SizedBox(height: 16),

          // --- 自定义通知 ---
          _sectionTitle('1. 自定义 Notification 监听'),
          NotificationListener<MyNotification>(
            onNotification: (notification) {
              setState(() {
                _notificationLog.insert(0, '[${notification.value}] ${notification.message}');
                if (_notificationLog.length > 10) _notificationLog.removeLast();
              });
              // 返回 true 拦截通知, false 继续向上冒泡
              return notification.value > 50;
            },
            child: const _SendNotificationWidget(),
          ),

          const SizedBox(height: 8),
          const Text('value > 50 的通知被拦截，不再向上传递', style: TextStyle(fontSize: 11, color: Colors.grey)),

          const SizedBox(height: 12),

          // 通知日志
          Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(8)),
            child: ListView.builder(
              itemCount: _notificationLog.length,
              itemBuilder: (context, i) {
                final isBlocked = _notificationLog[i].startsWith('[99');
                return Text(
                  _notificationLog[i],
                  style: TextStyle(
                    color: isBlocked ? Colors.orangeAccent : Colors.greenAccent,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // --- ScrollNotification ---
          _sectionTitle('2. ScrollNotification (滚动通知)'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(value: _scrollProgress),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification) {
                        setState(() {
                          _scrollProgress = (notification.metrics.pixels / notification.metrics.maxScrollExtent).clamp(0.0, 1.0);
                        });
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, i) => ListTile(
                        dense: true,
                        leading: CircleAvatar(radius: 14, child: Text('$i', style: const TextStyle(fontSize: 10))),
                        title: Text('列表项 $i'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text('滚动进度: ${(_scrollProgress * 100).toStringAsFixed(0)}%', style: const TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 20),

          // --- ScrollNotification 方向 ---
          _sectionTitle('3. ScrollNotification 类型'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ScrollStartNotification   — 滚动开始'),
                Text('• ScrollUpdateNotification  — 滚动中（持续触发）'),
                Text('• ScrollEndNotification     — 滚动结束'),
                Text('• OverscrollNotification    — 过度滚动'),
                Text('• UserScrollNotification    — 区分用户/程序滚动'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)));
  }
}
