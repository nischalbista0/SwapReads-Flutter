import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/exchange_request_entity.dart';
import '../repository/exchange_request_repository.dart';

final exchangeRequestUsecaseProvider =
    Provider.autoDispose<ExchangeRequestUseCase>(
  (ref) => ExchangeRequestUseCase(
    exchangeRequestRepository: ref.watch(exchangeRequestRepositoryProvider),
  ),
);

class ExchangeRequestUseCase {
  final IExchangeRequestRepository exchangeRequestRepository;

  ExchangeRequestUseCase({required this.exchangeRequestRepository});

  Future<Either<Failure, List<ExchangeRequestEntity>>> getExchangeRequests() {
    return exchangeRequestRepository.getExchangeRequests();
  }

  Future<Either<Failure, bool>> createExchangeRequest(
      ExchangeRequestEntity exchangeRequest, String requestedBook) {
    return exchangeRequestRepository.createExchangeRequest(
        exchangeRequest, requestedBook);
  }

  Future<Either<Failure, bool>> acceptExchangeRequest(String requestId) {
    return exchangeRequestRepository.acceptExchangeRequest(requestId);
  }

  Future<Either<Failure, bool>> declineExchangeRequest(String requestId) {
    return exchangeRequestRepository.declineExchangeRequest(requestId);
  }
}
