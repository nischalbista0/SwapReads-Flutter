import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swapreads/features/home/data/data_source/home_local_data_source.dart';

import '../../../../core/common/provider/network_connection.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entity/book_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_remote_data_source.dart';

final homeRemoteRepoProvider = Provider<IHomeRepository>(
  (ref) => HomeRemoteRepositoryImpl(
    homeRemoteDataSource: ref.read(homeRemoteDataSourceProvider),
    localDataSource: ref.read(homeLocalDataSourceProvider),
  ),
);

class HomeRemoteRepositoryImpl implements IHomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRemoteRepositoryImpl({
    required this.homeRemoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> addBook(BookEntity book) {
    return homeRemoteDataSource.addBook(book);
  }

  @override
  Future<Either<Failure, bool>> deleteBook(String bookId) {
    return homeRemoteDataSource.deleteBook(bookId);
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getAllBooks() async {
    final a = await checkConnectivity();

    if (a) {
      return await homeRemoteDataSource.getAllBooks();
    } else {
      return localDataSource.getAllBooks();
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBookById(String bookId) {
    return homeRemoteDataSource.getBookById(bookId);
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBookmarkedBooks() {
    return homeRemoteDataSource.getBookmarkedBooks();
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getUserBooks() {
    return homeRemoteDataSource.getUserBooks();
  }

  @override
  Future<Either<Failure, bool>> bookmarkBook(String bookId) {
    return homeRemoteDataSource.bookmarkBook(bookId);
  }

  @override
  Future<Either<Failure, bool>> unbookmarkBook(String bookId) {
    return homeRemoteDataSource.unbookmarkBook(bookId);
  }

  @override
  Future<Either<Failure, String>> uploadBookCover(File file) {
    return homeRemoteDataSource.uploadBookCover(file);
  }

  @override
  Future<Either<Failure, bool>> updateBook(BookEntity book, String bookId) {
    return homeRemoteDataSource.updateBook(book, bookId);
  }
}
