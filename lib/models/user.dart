class User {
  final String id;
  final String name;
  final String email;
  final String? role;
  final String? studentId;
  final String? studentNumber;
  final String? firstName;
  final String? lastName;
  final String? course;
  final String? year;
  final String? mobileNumber;
  final String? address;
  final String accountStatus; // e.g., Active, Suspended
  final String? libraryQrCode;
  final int borrowingLimit;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.role,
    this.studentId,
    this.studentNumber,
    this.firstName,
    this.lastName,
    this.course,
    this.year,
    this.mobileNumber,
    this.address,
    required this.accountStatus,
    this.libraryQrCode,
    required this.borrowingLimit,
  });

  factory User.fromApiJson(Map<String, dynamic> json) {
    final userJson = _asMap(json['user'] ?? json);
    final studentJson = _asMap(json['student']);

    return User(
      id: _stringValue(userJson['id']),
      name: _stringValue(
        userJson['name'] ??
            _studentName(studentJson) ??
            userJson['email'] ??
            'User',
      ),
      email: _stringValue(userJson['email']),
      role: userJson['role']?.toString(),
      studentId: _nullableString(studentJson['id'] ?? userJson['student_id']),
      studentNumber: _nullableString(studentJson['id_number']),
      firstName: _nullableString(
        studentJson['firstname'] ?? userJson['fname'] ?? userJson['first_name'],
      ),
      lastName: _nullableString(
        studentJson['lastname'] ?? userJson['lname'] ?? userJson['last_name'],
      ),
      course: _nullableString(studentJson['course']),
      year: _nullableString(studentJson['year']),
      mobileNumber: _nullableString(studentJson['mobile_number']),
      address: _nullableString(studentJson['address']),
      accountStatus: _stringValue(
        userJson['account_status'] ?? studentJson['status'] ?? 'Active',
      ),
      libraryQrCode: _nullableString(
        studentJson['qr_code'] ??
            studentJson['qr_code_data'] ??
            studentJson['library_qr_code'],
      ),
      borrowingLimit: _intValue(userJson['borrowing_limit'], fallback: 0),
    );
  }

  static Map<String, dynamic> _asMap(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, value) => MapEntry(key.toString(), value));
    }
    return const {};
  }

  static String _stringValue(Object? value) => value?.toString() ?? '';

  static String? _nullableString(Object? value) {
    final stringValue = value?.toString();
    return stringValue == null || stringValue.isEmpty ? null : stringValue;
  }

  static int _intValue(Object? value, {required int fallback}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  static String? _studentName(Map<String, dynamic> studentJson) {
    final firstName = _nullableString(
      studentJson['firstname'] ?? studentJson['first_name'],
    );
    final lastName = _nullableString(
      studentJson['lastname'] ?? studentJson['last_name'],
    );

    final parts = [firstName, lastName].whereType<String>().toList();
    return parts.isEmpty ? null : parts.join(' ');
  }
}
