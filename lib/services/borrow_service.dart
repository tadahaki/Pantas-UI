import '../models/borrowed_book.dart';

// Stub for borrow service
// Will be implemented with actual API calls
class BorrowService {
  static final BorrowService _instance = BorrowService._internal();

  factory BorrowService() {
    return _instance;
  }

  BorrowService._internal();

  final List<String> _borrowCart = [];

  List<String> getBorrowCart() {
    return _borrowCart;
  }

  void addToBorrowCart(String bookId) {
    if (!_borrowCart.contains(bookId)) {
      _borrowCart.add(bookId);
    }
  }

  void removeFromBorrowCart(String bookId) {
    _borrowCart.remove(bookId);
  }

  void clearBorrowCart() {
    _borrowCart.clear();
  }

  Future<List<BorrowedBook>> getCurrentBorrowedBooks() async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  Future<bool> submitCheckoutRequest(List<String> bookIds) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
    _borrowCart.clear();
    return true;
  }

  Future<bool> renewBook(String bookId) async {
    // TODO: Implement actual API call
    return true;
  }
}
