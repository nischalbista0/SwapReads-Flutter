import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swapreads/features/search/data/data_source/search_remote_data_source.dart';

import '../../../../core/failure/failure.dart';
import '../../../home/domain/entity/book_entity.dart';
import '../../domain/repository/search_repository.dart';

final searchRemoteRepoProvider = Provider<ISearchRepository>(
  (ref) => SearchRemoteRepositoryImpl(
    searchRemoteDataSource: ref.read(searchRemoteDataSourceProvider),
  ),
);

class SearchRemoteRepositoryImpl implements ISearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRemoteRepositoryImpl({required this.searchRemoteDataSource});

  @override
  Future<Either<Failure, List<BookEntity>>> getSearchedBooks(
      String searchQuery) {
    return searchRemoteDataSource.getSearchedBooks(searchQuery);
  }
}
