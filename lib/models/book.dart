class Book {
  final String id;
  final String title;
  final String author;
  final String? coverImage;
  final int year;
  final String callNumber;
  final String contentType; // e.g., Book, E-book
  final String section;
  final bool isAvailable;
  final int totalCopies;
  final int availableCopies;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.coverImage,
    required this.year,
    required this.callNumber,
    required this.contentType,
    required this.section,
    required this.isAvailable,
    required this.totalCopies,
    required this.availableCopies,
  });
}
