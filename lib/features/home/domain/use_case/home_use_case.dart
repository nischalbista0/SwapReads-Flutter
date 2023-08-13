import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/book_entity.dart';
import '../repository/home_repository.dart';

final homeUsecaseProvider = Provider.autoDispose<HomeUseCase>(
  (ref) => HomeUseCase(
    homeRepository: ref.watch(homeRepositoryProvider),
  ),
);

class HomeUseCase {
  final IHomeRepository homeRepository;

  HomeUseCase({required this.homeRepository});

  Future<Either<Failure, List<BookEntity>>> getAllBooks() {
    return homeRepository.getAllBooks();
  }

  Future<Either<Failure, List<BookEntity>>> getBookById(String bookId) {
    return homeRepository.getBookById(bookId);
  }

  Future<Either<Failure, List<BookEntity>>> getBookmarkedBooks() {
    return homeRepository.getBookmarkedBooks();
  }

  Future<Either<Failure, List<BookEntity>>> getUserBooks() {
    return homeRepository.getUserBooks();
  }

  Future<Either<Failure, bool>> addBook(BookEntity book) {
    return homeRepository.addBook(book);
  }

  Future<Either<Failure, bool>> updateBook(BookEntity book, String bookId) {
    return homeRepository.updateBook(book, bookId);
  }

  Future<Either<Failure, bool>> deleteBook(String bookId) {
    return homeRepository.deleteBook(bookId);
  }

  Future<Either<Failure, String>> uploadBookCover(File file) async {
    return await homeRepository.uploadBookCover(file);
  }

  Future<Either<Failure, bool>> bookmarkBook(String bookId) {
    return homeRepository.bookmarkBook(bookId);
  }

  Future<Either<Failure, bool>> unbookmarkBook(String bookId) {
    return homeRepository.unbookmarkBook(bookId);
  }
}
