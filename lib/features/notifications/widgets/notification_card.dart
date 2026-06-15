import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String type;
  final bool isRead;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
  });

  Color get iconColor {
    switch (type) {
      case 'due':
        return AppColors.warning;
      case 'overdue':
        return AppColors.danger;
      case 'room':
        return AppColors.primary;
      default:
        return AppColors.accent;
    }
  }

  IconData get iconData {
    switch (type) {
      case 'due':
        return Icons.schedule;
      case 'overdue':
        return Icons.warning;
      case 'room':
        return Icons.meeting_room;
      default:
        return Icons.announcement;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isRead ? AppColors.card : AppColors.primary.withAlpha((0.08 * 255).round()),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withAlpha((0.16 * 255).round()),
            child: Icon(iconData, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(message, style: const TextStyle(color: AppColors.textMuted)),
              ],
            ),
          ),
          if (!isRead)
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}
