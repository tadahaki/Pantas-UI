class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final Map<String, List<String>> errors;

  const ApiException({
    required this.message,
    this.statusCode,
    this.errors = const {},
  });

  bool get isUnauthenticated => statusCode == 401;
  bool get isValidationError => statusCode == 422;
  bool get isConflict => statusCode == 409;
  bool get isServerError => statusCode != null && statusCode! >= 500;

  String get validationSummary {
    if (errors.isEmpty) return message;
    return errors.values.expand((messages) => messages).join('\n');
  }

  @override
  String toString() => message;
}
