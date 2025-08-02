import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  const QuantitySelector({
    super.key,
    this.initialValue = 1,
    required this.onChanged,
    this.min = 1,
    this.max = 999,
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late TextEditingController _controller;
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.clamp(widget.min, widget.max);
    _controller = TextEditingController(text: _currentValue.toString());
  }

  void _updateValue(int newValue) {
    newValue = newValue.clamp(widget.min, widget.max);
    if (_currentValue != newValue) {
      setState(() {
        _currentValue = newValue;
        _controller.text = _currentValue.toString();
      });
      widget.onChanged(_currentValue);
    }
  }

  void _onTextChanged(String value) {
    final int? parsed = int.tryParse(value);
    if (parsed != null) {
      _updateValue(parsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _currentValue > widget.min
              ? () => _updateValue(_currentValue - 1)
              : null,
        ),
        SizedBox(
          width: 50,
          height: 30,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: _onTextChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 2),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _currentValue < widget.max
              ? () => _updateValue(_currentValue + 1)
              : null,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
