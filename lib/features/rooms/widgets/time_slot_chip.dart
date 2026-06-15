import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TimeSlotChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const TimeSlotChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: selected ? AppColors.primary : AppColors.card,
      labelStyle: TextStyle(color: selected ? Colors.white : AppColors.textPrimary),
      elevation: 0,
    );
  }
}
