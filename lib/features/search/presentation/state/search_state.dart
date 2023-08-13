import '../../../home/domain/entity/book_entity.dart';

class SearchState {
  final bool isLoading;
  final List<BookEntity> searchedBooks;
  final String? error;

  SearchState({
    required this.isLoading,
    required this.searchedBooks,
    this.error,
  });

  factory SearchState.initial() {
    return SearchState(isLoading: false, searchedBooks: []);
  }

  SearchState copyWith({
    bool? isLoading,
    List<BookEntity>? searchedBooks,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      searchedBooks: searchedBooks ?? this.searchedBooks,
      error: error ?? this.error,
    );
  }
}
