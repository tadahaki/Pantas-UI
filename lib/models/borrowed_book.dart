class BorrowedBook {
  final String id;
  final String title;
  final String author;
  final DateTime dueDate;
  final DateTime borrowDate;
  final bool isOverdue;
  final String status; // e.g., Active, Reserved, Returned

  BorrowedBook({
    required this.id,
    required this.title,
    required this.author,
    required this.dueDate,
    required this.borrowDate,
    required this.isOverdue,
    required this.status,
  });
}
