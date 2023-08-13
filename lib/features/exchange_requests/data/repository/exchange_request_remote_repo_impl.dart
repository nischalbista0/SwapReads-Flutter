import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/exchange_request_entity.dart';
import '../../domain/repository/exchange_request_repository.dart';
import '../data_source/exchange_request_remote_data_source.dart';

final exchangeRequestRemoteRepoProvider = Provider<IExchangeRequestRepository>(
  (ref) => ExchangeRequestRemoteRepositoryImpl(
    exchangeRequestRemoteDataSource:
        ref.read(exchangeRequestRemoteDataSourceProvider),
  ),
);

class ExchangeRequestRemoteRepositoryImpl
    implements IExchangeRequestRepository {
  final ExchangeRequestRemoteDataSource exchangeRequestRemoteDataSource;

  ExchangeRequestRemoteRepositoryImpl(
      {required this.exchangeRequestRemoteDataSource});

  @override
  Future<Either<Failure, List<ExchangeRequestEntity>>> getExchangeRequests() {
    return exchangeRequestRemoteDataSource.getExchangeRequests();
  }

  @override
  Future<Either<Failure, bool>> createExchangeRequest(
      ExchangeRequestEntity exchangeRequest, String requestedBook) {
    return exchangeRequestRemoteDataSource.createExchangeRequest(
        exchangeRequest, requestedBook);
  }

  @override
  Future<Either<Failure, bool>> acceptExchangeRequest(String requestId) {
    return exchangeRequestRemoteDataSource.acceptExchangeRequest(requestId);
  }

  @override
  Future<Either<Failure, bool>> declineExchangeRequest(String requestId) {
    return exchangeRequestRemoteDataSource.declineExchangeRequest(requestId);
  }
}
