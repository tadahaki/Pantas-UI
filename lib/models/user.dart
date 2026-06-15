class User {
  final String id;
  final String name;
  final String email;
  final String? studentId;
  final String accountStatus; // e.g., Active, Suspended
  final String? libraryQrCode;
  final int borrowingLimit;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.studentId,
    required this.accountStatus,
    this.libraryQrCode,
    required this.borrowingLimit,
  });
}
