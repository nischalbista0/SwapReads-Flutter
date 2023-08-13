class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3001/";
  // static const String baseUrl = "http://172.26.1.22:3000/api/v1/";
  // static const String baseUrl = "http://192.168.137.1:3000/api/v1/";
  static const String baseUrl = "http://192.168.137.1:3001/";

  // ====================== Auth Routes ======================
  static const String login = "users/login";
  static const String register = "users/register";

  static const String uploadImage = "users/uploadImage";

  static const String getAllBooks = "books/others";
  static String getBookById(String bookId) => "books/$bookId";
  static const String getBookmarkedBooks = "books/bookmarked-books";
  static const String getUserBooks = "books/my-books";
  static const String uploadBookCover = "books/uploadBookCover";

  static const String addBook = "books/";
  static String updateBook(String bookId) => "books/$bookId";
  static String deleteBook(String bookId) => "books/$bookId";
  static String bookmarkBook(String bookId) => "books/bookmark/$bookId";
  static String unbookmarkBook(String bookId) => "books/bookmark/$bookId";
  static const String searchBooks = "books/search";

  static const String getUserProfile = "users/";
  static const String changePassword = "users/change-password";
  static const String editProfile = "users/edit-profile";

  static String createExchangeRequest(String requestedBook) =>
      "exchange/$requestedBook/exchange-request";
  static const String getExchangeRequests = "exchange/exchange-requests/";
  static String acceptExchangeRequest(String requestId) =>
      "exchange/exchange-request/$requestId/accept";
  static String declineExchangeRequest(String requestId) =>
      "exchange/exchange-request/$requestId/decline";
}
