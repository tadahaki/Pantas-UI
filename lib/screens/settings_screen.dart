import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _dueDateReminders = true;
  bool _overdueAlerts = true;
  bool _reservationUpdates = true;
  bool _announcements = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Preferences
            Text(
              'Notification Preferences',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildNotificationSwitch(
              title: 'Push Notifications',
              subtitle: 'Receive push notifications from the library',
              value: _pushNotifications,
              onChanged: (value) {
                setState(() {
                  _pushNotifications = value;
                });
              },
            ),
            const Divider(),
            _buildNotificationSwitch(
              title: 'Due Date Reminders',
              subtitle: 'Get notified when books are due soon',
              value: _dueDateReminders,
              onChanged: (value) {
                setState(() {
                  _dueDateReminders = value;
                });
              },
            ),
            const Divider(),
            _buildNotificationSwitch(
              title: 'Overdue Alerts',
              subtitle: 'Get alerted about overdue items',
              value: _overdueAlerts,
              onChanged: (value) {
                setState(() {
                  _overdueAlerts = value;
                });
              },
            ),
            const Divider(),
            _buildNotificationSwitch(
              title: 'Reservation Updates',
              subtitle: 'Get updates about your room reservations',
              value: _reservationUpdates,
              onChanged: (value) {
                setState(() {
                  _reservationUpdates = value;
                });
              },
            ),
            const Divider(),
            _buildNotificationSwitch(
              title: 'Announcements',
              subtitle: 'Receive library announcements and news',
              value: _announcements,
              onChanged: (value) {
                setState(() {
                  _announcements = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // App Information
            Text(
              'App Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildInfoTile(
              title: 'App Version',
              value: '1.0.0',
            ),
            _buildInfoTile(
              title: 'Build Number',
              value: '1',
            ),
            const SizedBox(height: 24),

            // About
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About PANTAS',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'PANTAS is a mobile library management application designed to help students and patrons search the catalog, borrow books, reserve rooms, and track their library account.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
