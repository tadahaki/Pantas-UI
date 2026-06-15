import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, dynamic>> notifications = const [
    {
      'title': 'Due date reminder',
      'message': 'Your reserved book is due tomorrow.',
      'type': 'due',
      'isRead': false,
    },
    {
      'title': 'Overdue notice',
      'message': 'Return "Research Methods" to avoid fine.',
      'type': 'overdue',
      'isRead': false,
    },
    {
      'title': 'Room reservation update',
      'message': 'Your room reservation is pending approval.',
      'type': 'room',
      'isRead': true,
    },
    {
      'title': 'Library announcement',
      'message': 'New hours available this weekend.',
      'type': 'announcement',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final note = notifications[index];
              return NotificationCard(
                title: note['title'] as String,
                message: note['message'] as String,
                type: note['type'] as String,
                isRead: note['isRead'] as bool,
              );
            },
          ),
        ),
      ),
    );
  }
}
