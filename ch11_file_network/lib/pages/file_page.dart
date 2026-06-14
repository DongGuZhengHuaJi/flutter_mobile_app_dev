import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// 11.1 文件操作
/// 演示: File 读写, Directory 遍历, 文件信息

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  String _content = '';
  final _controller = TextEditingController();
  List<FileSystemEntity> _files = [];
  String _appDir = '';
  String _status = '';

  @override
  void initState() {
    super.initState();
    _initDir();
  }

  Future<void> _initDir() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      _appDir = dir.path;
      await _refreshFileList();
    } catch (e) {
      _appDir = Directory.current.path;
      await _refreshFileList();
    }
  }

  Future<void> _refreshFileList() async {
    try {
      final dir = Directory('$_appDir/ch11_demo');
      if (!dir.existsSync()) dir.createSync(recursive: true);
      setState(() {
        _files = dir.listSync();
        _status = '目录: ${dir.path}';
      });
    } catch (e) {
      setState(() => _status = '错误: $e');
    }
  }

  Future<void> _writeFile() async {
    if (_controller.text.isEmpty) return;
    final file = File('$_appDir/ch11_demo/note_${DateTime.now().millisecondsSinceEpoch}.txt');
    await file.writeAsString(_controller.text);
    _controller.clear();
    await _refreshFileList();
    setState(() => _status = '已保存');
  }

  Future<void> _readFile(FileSystemEntity entity) async {
    if (entity is File) {
      final content = await entity.readAsString();
      setState(() {
        _content = content;
        _status = '读取: ${entity.path.split('/').last}';
      });
    }
  }

  Future<void> _deleteFile(FileSystemEntity entity) async {
    await entity.delete();
    await _refreshFileList();
    setState(() => _status = '已删除');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('1. 写入文件'),
          TextField(
            controller: _controller,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: '输入要保存的内容...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _writeFile,
            icon: const Icon(Icons.save),
            label: const Text('保存到文件'),
          ),

          const SizedBox(height: 16),

          _sectionTitle('2. 文件列表'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(8)),
            child: Text(_status, style: const TextStyle(fontSize: 12, color: Colors.cyan)),
          ),
          const SizedBox(height: 8),
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: _files.isEmpty
                ? const Center(child: Text('暂无文件', style: TextStyle(color: Colors.grey)))
                : ListView.separated(
                    itemCount: _files.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final entity = _files[i];
                      final name = entity.path.split('/').last;
                      final stat = entity.statSync();
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.description, size: 20),
                        title: Text(name, style: const TextStyle(fontSize: 13)),
                        subtitle: Text('${stat.size} bytes', style: const TextStyle(fontSize: 11)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(icon: const Icon(Icons.visibility, size: 18), onPressed: () => _readFile(entity)),
                            IconButton(icon: const Icon(Icons.delete, size: 18, color: Colors.red), onPressed: () => _deleteFile(entity)),
                          ],
                        ),
                        onTap: () => _readFile(entity),
                      );
                    },
                  ),
          ),

          const SizedBox(height: 16),

          _sectionTitle('3. 读取内容'),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 80),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(_content.isEmpty ? '点击文件查看内容...' : _content, style: TextStyle(color: _content.isEmpty ? Colors.grey : Colors.black87)),
          ),

          const SizedBox(height: 20),

          _sectionTitle('文件操作 API 摘要'),
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
        _ApiRow('File(path)', '文件引用'),
        _ApiRow('.readAsString()', '异步读取文本内容'),
        _ApiRow('.writeAsString(str)', '异步写入文本'),
        _ApiRow('.existsSync()', '同步检查是否存在'),
        _ApiRow('.delete()', '删除文件'),
        _ApiRow('Directory(path)', '目录引用'),
        _ApiRow('.listSync()', '同步列出内容'),
        _ApiRow('.createSync()', '同步创建目录'),
        _ApiRow('.statSync()', '获取文件/目录信息'),
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
