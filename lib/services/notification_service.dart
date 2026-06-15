import '../models/notification_model.dart';

// Stub for notification service
// Will be implemented with actual API calls
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<List<NotificationModel>> getNotifications() async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  Future<bool> markAsRead(String notificationId) async {
    // TODO: Implement actual API call
    return true;
  }

  Future<int> getUnreadCount() async {
    // TODO: Implement actual API call
    return 0;
  }
}
