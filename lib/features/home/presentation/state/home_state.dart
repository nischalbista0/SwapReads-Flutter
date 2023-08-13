import '../../domain/entity/book_entity.dart';

class HomeState {
  final bool isLoading;
  final List<BookEntity> books;
  final List<BookEntity> bookmarkedBooks;
  final List<BookEntity> userBooks;
  final List<BookEntity> bookById;
  final String? error;
  final String? imageName;

  HomeState({
    required this.isLoading,
    required this.books,
    required this.bookmarkedBooks,
    required this.userBooks,
    required this.bookById,
    this.error,
    this.imageName,
  });

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      books: [],
      bookmarkedBooks: [],
      userBooks: [],
      bookById: [],
      error: null,
      imageName: null,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    List<BookEntity>? books,
    List<BookEntity>? bookmarkedBooks,
    List<BookEntity>? userBooks,
    List<BookEntity>? bookById,
    String? imageName,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      books: books ?? this.books,
      bookmarkedBooks: bookmarkedBooks ?? this.bookmarkedBooks,
      userBooks: userBooks ?? this.userBooks,
      bookById: bookById ?? this.bookById,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
    );
  }
}
