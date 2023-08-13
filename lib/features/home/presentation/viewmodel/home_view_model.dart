import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/book_entity.dart';
import '../../domain/use_case/home_use_case.dart';
import '../state/home_state.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(ref.read(homeUsecaseProvider)),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final HomeUseCase homeUseCase;

  HomeViewModel(this.homeUseCase) : super(HomeState.initial()) {
    getAllBooks();
    getBookmarkedBooks();
    getUserBooks();
  }

  addBook(BookEntity book) async {
    state.copyWith(isLoading: true);
    var data = await homeUseCase.addBook(book);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  updateBook(BookEntity book, String bookId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.updateBook(book, bookId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  deleteBook(String bookId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.deleteBook(bookId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> uploadBookCover(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.uploadBookCover(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  getAllBooks() async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.getAllBooks();
    state = state.copyWith(books: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, books: r, error: null),
    );
  }

  getBookById(String bookId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.getBookById(bookId);
    state = state.copyWith(bookById: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, bookById: r, error: null),
    );
  }

  getBookmarkedBooks() async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.getBookmarkedBooks();
    state = state.copyWith(bookmarkedBooks: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state =
          state.copyWith(isLoading: false, bookmarkedBooks: r, error: null),
    );
  }

  getUserBooks() async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.getUserBooks();
    state = state.copyWith(userBooks: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) =>
          state = state.copyWith(isLoading: false, userBooks: r, error: null),
    );
  }

  bookmarkBook(String bookId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.bookmarkBook(bookId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  unbookmarkBook(String bookId) async {
    state = state.copyWith(isLoading: true);
    var data = await homeUseCase.unbookmarkBook(bookId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }
}
