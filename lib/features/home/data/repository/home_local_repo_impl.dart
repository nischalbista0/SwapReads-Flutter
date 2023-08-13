import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/book_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_local_data_source.dart';

final homeLocalRepoProvider = Provider<IHomeRepository>((ref) {
  return HomeLocalRepositoryImpl(
    homeLocalDataSource: ref.read(homeLocalDataSourceProvider),
  );
});

class HomeLocalRepositoryImpl implements IHomeRepository {
  final HomeLocalDataSource homeLocalDataSource;

  HomeLocalRepositoryImpl({required this.homeLocalDataSource});
  @override
  Future<Either<Failure, bool>> addBook(BookEntity book) {
    return homeLocalDataSource.addBook(book);
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getAllBooks() {
    return homeLocalDataSource.getAllBooks();
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBookmarkedBooks() {
    return homeLocalDataSource.getBookmarkedBooks();
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getUserBooks() {
    return homeLocalDataSource.getUserBooks();
  }

  @override
  Future<Either<Failure, bool>> bookmarkBook(String bookId) {
    // TODO: implement bookmarkBook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadBookCover(File file) async {
    return const Right("");
  }

  @override
  Future<Either<Failure, bool>> unbookmarkBook(String bookId) {
    // TODO: implement unbookmarkBook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBookById(String bookId) {
    // TODO: implement getBookById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteBook(String bookId) {
    // TODO: implement deleteBook
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, bool>> updateBook(BookEntity book, String bookId) {
    // TODO: implement updateBook
    throw UnimplementedError();
  }
}
