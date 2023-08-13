import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/exchange_request_remote_repo_impl.dart';
import '../entity/exchange_request_entity.dart';

final exchangeRequestRepositoryProvider =
    Provider.autoDispose<IExchangeRequestRepository>(
  (ref) {
    // return ref.watch(batchLocalRepoProvider);
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    return ref.watch(exchangeRequestRemoteRepoProvider);

    // if (ConnectivityStatus.isConnected == internetStatus) {
    //   // If internet is available then return remote repo
    //   return ref.watch(exchangeRequestRemoteRepoProvider);
    // } else {
    //   // If internet is not available then return local repo
    //   return ref.watch(exchangeRequestLocalRepoProvider);
    // }
  },
);

abstract class IExchangeRequestRepository {
  Future<Either<Failure, List<ExchangeRequestEntity>>> getExchangeRequests();
  Future<Either<Failure, bool>> createExchangeRequest(
      ExchangeRequestEntity exchangeRequest, String requestedBook);
  Future<Either<Failure, bool>> acceptExchangeRequest(String requestId);
  Future<Either<Failure, bool>> declineExchangeRequest(String requestId);
}
