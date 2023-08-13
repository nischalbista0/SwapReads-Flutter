import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/home_remote_repo_impl.dart';
import '../entity/book_entity.dart';

final homeRepositoryProvider = Provider.autoDispose<IHomeRepository>(
  (ref) {
    return ref.watch(homeRemoteRepoProvider);
  },
);

abstract class IHomeRepository {
  Future<Either<Failure, List<BookEntity>>> getAllBooks();
  Future<Either<Failure, List<BookEntity>>> getBookById(String bookId);
  Future<Either<Failure, List<BookEntity>>> getBookmarkedBooks();
  Future<Either<Failure, List<BookEntity>>> getUserBooks();
  Future<Either<Failure, bool>> addBook(BookEntity book);
  Future<Either<Failure, bool>> updateBook(BookEntity book, String bookId);
  Future<Either<Failure, bool>> deleteBook(String bookId);
  Future<Either<Failure, String>> uploadBookCover(File file);
  Future<Either<Failure, bool>> bookmarkBook(String bookId);
  Future<Either<Failure, bool>> unbookmarkBook(String bookId);
}
