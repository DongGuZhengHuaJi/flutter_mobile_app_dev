import 'package:flutter/material.dart';

/// 3.4 单选开关和复选框
/// 演示: Switch, Checkbox, Radio, Slider, SwitchListTile 等

class SwitchCheckboxPage extends StatefulWidget {
  const SwitchCheckboxPage({super.key});

  @override
  State<SwitchCheckboxPage> createState() => _SwitchCheckboxPageState();
}

class _SwitchCheckboxPageState extends State<SwitchCheckboxPage> {
  // Switch 状态
  bool _switchValue = false;
  bool _switchEnabled = true;

  // Checkbox 状态
  bool _checkboxA = false;
  bool _checkboxB = true;
  bool? _checkboxTriState = false; // 三态

  // Radio 状态
  int _radioGroup = 0;

  // Slider 状态
  double _sliderValue = 30;
  double _rangeStart = 20;
  double _rangeEnd = 70;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Switch ---
          _sectionTitle('1. Switch (开关)'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Wi-Fi'),
              Switch(
                value: _switchValue,
                activeThumbColor: Colors.blue,
                onChanged: _switchEnabled
                    ? (v) => setState(() => _switchValue = v)
                    : null,
              ),
            ],
          ),
          SwitchListTile(
            title: const Text('蓝牙'),
            subtitle: Text(_switchEnabled ? '已开启' : '已禁用'),
            value: _switchEnabled,
            onChanged: (v) => setState(() => _switchEnabled = v),
            secondary: Icon(
              _switchEnabled ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
            ),
          ),

          const SizedBox(height: 16),

          // --- Checkbox ---
          _sectionTitle('2. Checkbox (复选框)'),
          CheckboxListTile(
            title: const Text('同意用户协议'),
            value: _checkboxA,
            onChanged: (v) => setState(() => _checkboxA = v!),
          ),
          CheckboxListTile(
            title: const Text('订阅邮件通知'),
            subtitle: const Text('每周接收最新资讯'),
            value: _checkboxB,
            onChanged: (v) => setState(() => _checkboxB = v!),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          // 三态复选框
          CheckboxListTile(
            title: Text('三态复选框: $_checkboxTriState'),
            tristate: true,
            value: _checkboxTriState,
            onChanged: (v) => setState(() {
              // null -> true -> false -> null 循环
              if (_checkboxTriState == null) {
                _checkboxTriState = true;
              } else if (_checkboxTriState == true) {
                _checkboxTriState = false;
              } else {
                _checkboxTriState = null;
              }
            }),
          ),

          // 自定义颜色
          Row(
            children: [
              Checkbox(
                value: true,
                checkColor: Colors.white,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) return Colors.green;
                  return Colors.transparent;
                }),
                onChanged: (_) {},
              ),
              const Text('自定义颜色'),
            ],
          ),

          const SizedBox(height: 16),

          // --- Radio ---
          _sectionTitle('3. Radio (单选按钮)'),
          RadioGroup<int?>(
            groupValue: _radioGroup,
            onChanged: (v) => setState(() => _radioGroup = v ?? 0),
            child: Column(
              children: [
                RadioListTile<int>(
                  title: const Text('选项 A'),
                  value: 0,
                ),
                RadioListTile<int>(
                  title: const Text('选项 B'),
                  subtitle: const Text('推荐'),
                  value: 1,
                ),
                RadioListTile<int>(
                  title: const Text('选项 C (禁用)'),
                  value: 2,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // --- Slider ---
          _sectionTitle('4. Slider (滑块)'),
          Row(
            children: [
              const Text('音量'),
              Expanded(
                child: Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: '${_sliderValue.round()}',
                  onChanged: (v) => setState(() => _sliderValue = v),
                ),
              ),
              Text('${_sliderValue.round()}%'),
            ],
          ),

          // RangeSlider
          const SizedBox(height: 8),
          RangeSlider(
            values: RangeValues(_rangeStart, _rangeEnd),
            min: 0,
            max: 100,
            divisions: 20,
            labels: RangeLabels('${_rangeStart.round()}', '${_rangeEnd.round()}'),
            onChanged: (v) => setState(() {
              _rangeStart = v.start;
              _rangeEnd = v.end;
            }),
          ),
          Center(
            child: Text('价格区间: ${_rangeStart.round()} - ${_rangeEnd.round()} 元'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
      ),
    );
  }
}
