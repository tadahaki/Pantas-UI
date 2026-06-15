class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type; // e.g., due_date, overdue, reservation, checkout, announcement
  final DateTime createdAt;
  final bool isRead;
  final String? relatedId; // ID of related book, reservation, etc.

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    required this.isRead,
    this.relatedId,
  });
}
