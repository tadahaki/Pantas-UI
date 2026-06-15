class MockBook {
  final String id;
  final String title;
  final String author;
  final String callNumber;
  final String availability;
  final String coverUrl;
  final String year;
  final String description;
  final int copies;
  final bool isAvailable;

  const MockBook({
    required this.id,
    required this.title,
    required this.author,
    required this.callNumber,
    required this.availability,
    required this.coverUrl,
    required this.year,
    required this.description,
    required this.copies,
    required this.isAvailable,
  });
}
