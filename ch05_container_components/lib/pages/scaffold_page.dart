import 'package:flutter/material.dart';

/// 5.7 页面骨架: Scaffold, AppBar, Drawer, BottomSheet, SnackBar

class ScaffoldPage extends StatelessWidget {
  const ScaffoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Scaffold — 页面骨架结构'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.teal.shade200),
            ),
            child: const DefaultTextStyle(
              style: TextStyle(color: Colors.teal, fontSize: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('▸ AppBar          — 顶部导航栏'),
                  Text('▸ body            — 主体内容区'),
                  Text('▸ bottomNavigationBar — 底部导航栏'),
                  Text('▸ floatingActionButton — 浮动按钮'),
                  Text('▸ drawer            — 左侧抽屉'),
                  Text('▸ endDrawer         — 右侧抽屉'),
                  Text('▸ bottomSheet       — 底部弹出层'),
                  Text('▸ snackBar          — 消息提示条'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          _sectionTitle('1. AppBar 自定义'),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.antiAlias,
            child: AppBar(
              leading: const Icon(Icons.menu),
              title: const Text('AppBar 示例'),
              centerTitle: true,
              actions: const [
                Icon(Icons.search),
                SizedBox(width: 8),
                Icon(Icons.more_vert),
                SizedBox(width: 8),
              ],
            ),
          ),
          const Text('leading + title + actions 经典三区结构', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 20),

          _sectionTitle('2. FAB 位置'),
          Container(
            height: 120,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: Stack(
              children: [
                const Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(onPressed: null, child: Icon(Icons.add)),
                ),
                Positioned(
                  left: 16,
                  bottom: 50,
                  child: FloatingActionButton.small(onPressed: null, child: const Icon(Icons.edit)),
                ),
                const Positioned(
                  left: 16,
                  bottom: 0,
                  child: Text('centerDocked', style: TextStyle(fontSize: 11, color: Colors.grey)),
                ),
              ],
            ),
          ),
          const Text('FAB 位置: centerDocked / endFloat / centerFloat', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 20),

          _sectionTitle('3. SnackBar + SnackBarAction'),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('这是一条消息提示'),
                  action: SnackBarAction(label: '撤销', onPressed: () {}),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            icon: const Icon(Icons.info),
            label: const Text('显示 SnackBar'),
          ),

          const SizedBox(height: 12),

          _sectionTitle('4. BottomSheet'),
          ElevatedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                        const SizedBox(height: 20),
                        ListTile(leading: const Icon(Icons.share), title: const Text('分享'), onTap: () => Navigator.pop(context)),
                        ListTile(leading: const Icon(Icons.link), title: const Text('复制链接'), onTap: () => Navigator.pop(context)),
                        ListTile(leading: const Icon(Icons.delete), title: const Text('删除'), onTap: () => Navigator.pop(context)),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.vertical_align_bottom),
            label: const Text('显示 BottomSheet'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange)));
  }
}
