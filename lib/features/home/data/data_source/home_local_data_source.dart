import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/local/hive_service.dart';
import '../../domain/entity/book_entity.dart';
import '../model/home_hive_model.dart';

// Dependency Injection using Riverpod
final homeLocalDataSourceProvider = Provider<HomeLocalDataSource>((ref) {
  return HomeLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      homeHiveModel: ref.read(homeHiveModelProvider));
});

class HomeLocalDataSource {
  final HiveService hiveService;
  final HomeHiveModel homeHiveModel;

  HomeLocalDataSource({
    required this.hiveService,
    required this.homeHiveModel,
  });

  // Add Batch
  Future<Either<Failure, bool>> addBook(BookEntity book) async {
    try {
      // Convert Entity to Hive Object
      final hiveBook = homeHiveModel.toHiveModel(book);
      // Add to Hive
      await hiveService.addBook(hiveBook);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<BookEntity>>> getAllBooks() async {
    try {
      // Get all batches from Hive
      final books = await hiveService.getAllBooks();
      // Convert Hive Object to Entity
      final homeEntities = homeHiveModel.toEntityList(books);
      print(homeEntities);
      return Right(homeEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<BookEntity>>> getBookmarkedBooks() async {
    try {
      // Get all batches from Hive
      final books = await hiveService.getBookmarkedBooks();
      // Convert Hive Object to Entity
      final homeEntities = homeHiveModel.toEntityList(books);
      return Right(homeEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<BookEntity>>> getUserBooks() async {
    try {
      // Get all batches from Hive
      final books = await hiveService.getUserBooks();
      // Convert Hive Object to Entity
      final homeEntities = homeHiveModel.toEntityList(books);
      return Right(homeEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
