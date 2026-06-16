import '../models/book.dart';
import '../core/network/api_client.dart';

class CatalogService {
  static final CatalogService _instance = CatalogService._internal();

  factory CatalogService() => _instance;

  CatalogService._internal();

  final ApiClient _apiClient = ApiClient();

  Future<List<Book>> getNewArrivals({int limit = 12}) async {
    final response = await _apiClient.get(
      '/catalog/new-arrivals',
      authenticated: false,
      queryParameters: {'limit': limit},
    );

    final data = response['data'];
    if (data is! List) return const [];

    return data
        .map((item) => Book.fromJson(_asMap(item)))
        .toList(growable: false);
  }

  Future<List<Book>> searchBooks(
    String query, {
    String? format,
    String? section,
    String? subject,
    String? course,
    int page = 1,
    int perPage = 10,
  }) async {
    final catalogPage = await searchCatalog(
      query,
      format: format,
      section: section,
      subject: subject,
      course: course,
      page: page,
      perPage: perPage,
    );

    return catalogPage.books;
  }

  Future<CatalogPage> searchCatalog(
    String query, {
    String? format,
    String? section,
    String? subject,
    String? course,
    int page = 1,
    int perPage = 10,
  }) async {
    final response = await _apiClient.get(
      '/catalog/search',
      authenticated: false,
      queryParameters: {
        'search': query.trim(),
        'view': format == 'ebooks' || format == 'E-book' ? 'ebooks' : 'books',
        'course': course,
        'content_type': format == 'ebooks' || format == 'E-book'
            ? null
            : format,
        'section': section,
        'subject_topic': subject,
        'page': page,
        'per_page': perPage,
      }..removeWhere((_, value) => value == null || value == ''),
    );

    return CatalogPage.fromJson(response);
  }

  Future<Book?> getBookDetails(String bookId) async {
    final details = await getBookDetail(bookId);
    return details.book;
  }

  Future<BookDetails> getBookDetail(String bookId) async {
    final response = await _apiClient.get(
      '/catalog/books/$bookId',
      authenticated: false,
    );

    return BookDetails.fromJson(response);
  }

  Future<CatalogFilters> getFilters() async {
    final response = await _apiClient.get(
      '/catalog/filters',
      authenticated: false,
    );

    return CatalogFilters.fromJson(_asMap(response['data']));
  }

  Future<List<Book>> getFavorites() async {
    // Favorites do not have a mobile API endpoint yet.
    return [];
  }

  Future<bool> addToFavorites(String bookId) async {
    // Favorites do not have a mobile API endpoint yet.
    return true;
  }

  Future<bool> removeFromFavorites(String bookId) async {
    // Favorites do not have a mobile API endpoint yet.
    return true;
  }

  Map<String, dynamic> _asMap(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, value) => MapEntry(key.toString(), value));
    }
    return const {};
  }
}
