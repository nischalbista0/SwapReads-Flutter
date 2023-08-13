import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/search_use_case.dart';
import '../state/search_state.dart';

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>(
  (ref) => SearchViewModel(ref.read(searchUsecaseProvider)),
);

class SearchViewModel extends StateNotifier<SearchState> {
  final SearchUseCase searchUseCase;

  SearchViewModel(this.searchUseCase) : super(SearchState.initial()) {
    // getSearchedBooks(searchQuery);
  }

  getSearchedBooks(String searchQuery) async {
    state = state.copyWith(isLoading: true);
    final result = await searchUseCase.getSearchedBooks(searchQuery);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
        searchedBooks: [],
      ),
      (books) => state = state.copyWith(
        isLoading: false,
        searchedBooks: books,
      ),
    );
  }
}
