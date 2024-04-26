import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 0.70, child: Switch(onChanged: (value) {}, value: true));
  }
}
