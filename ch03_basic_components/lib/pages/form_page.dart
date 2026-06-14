import 'package:flutter/material.dart';

/// 3.5 输入框及表单
/// 演示: TextField, TextFormField, Form, 输入校验, 焦点控制, 键盘类型

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  // 控制器
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();

  // 焦点
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _emailFocus = FocusNode();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('表单验证通过！'), backgroundColor: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 基本 TextField ---
            _sectionTitle('1. 基本输入框'),
            TextField(
              decoration: const InputDecoration(
                labelText: '请输入内容',
                hintText: '这是提示文字',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // --- TextFormField 表单 ---
            _sectionTitle('2. 带验证的表单输入'),
            TextFormField(
              controller: _usernameController,
              focusNode: _usernameFocus,
              decoration: const InputDecoration(
                labelText: '用户名',
                helperText: '4-16位字母/数字',
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                _passwordFocus.requestFocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) return '请输入用户名';
                if (value.length < 4) return '用户名至少4位';
                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: '密码',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return '请输入密码';
                if (value.length < 6) return '密码至少6位';
                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: '邮箱',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return '请输入邮箱';
                if (!value.contains('@')) return '请输入有效邮箱';
                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: '手机号',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty && value.length != 11) {
                  return '手机号应为11位';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // --- 键盘类型 ---
            _sectionTitle('3. keyboardType 示例'),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '数字键盘 (number)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // --- 多行 ---
            _sectionTitle('4. 多行文本输入'),
            TextField(
              controller: _bioController,
              maxLines: 3,
              maxLength: 100,
              decoration: const InputDecoration(
                labelText: '个人简介',
                hintText: '不超过100字...',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // --- 输入格式化 ---
            _sectionTitle('5. 输入格式化 (inputFormatters)'),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '仅数字',
                border: OutlineInputBorder(),
              ),
              inputFormatters: const [],
            ),

            const SizedBox(height: 24),

            // --- 提交按钮 ---
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.check),
                label: const Text('提交表单', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
      ),
    );
  }
}
