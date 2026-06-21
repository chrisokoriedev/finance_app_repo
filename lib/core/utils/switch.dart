import 'package:expense_app/core/theme/neu_theme.dart';
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
    final neu = context.neu;
    return Transform.scale(
      scale: 0.72,
      child: Switch(
        value: value!,
        onChanged: onChanged,
        activeColor: neu.surface,
        activeTrackColor: neu.primary,
        inactiveThumbColor: neu.textSecondary,
        inactiveTrackColor: neu.shadowDark,
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }
}
