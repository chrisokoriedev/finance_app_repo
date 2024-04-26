import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool? value;
  final Function(bool)? onChanged;
  const CustomSwitch({
    super.key,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 0.70, child: Switch(onChanged: onChanged, value: value!));
  }
}
