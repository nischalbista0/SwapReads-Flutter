import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/exchange_request_entity.dart';
import '../dto/get_exchange_requests_dto.dart';
import '../model/exchange_request_api_model.dart';

final exchangeRequestRemoteDataSourceProvider = Provider(
  (ref) => ExchangeRequestRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    exchangeRequestApiModel: ref.read(exchangeRequestApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class ExchangeRequestRemoteDataSource {
  final Dio dio;
  final ExchangeRequestApiModel exchangeRequestApiModel;
  final UserSharedPrefs userSharedPrefs;

  ExchangeRequestRemoteDataSource({
    required this.dio,
    required this.exchangeRequestApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<ExchangeRequestEntity>>>
      getExchangeRequests() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.getExchangeRequests,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetExchangeRequestsDTO exchangeAddDTO =
            GetExchangeRequestsDTO.fromJson(response.data);
        return Right(exchangeRequestApiModel.toEntityList(exchangeAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> createExchangeRequest(
      ExchangeRequestEntity exchangeRequest, String requestedBook) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.post(
        ApiEndpoints.createExchangeRequest(requestedBook),
        data: {
          "requestedBook": requestedBook,
          "proposalBook": exchangeRequest.proposalBook,
          "message": exchangeRequest.message,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> acceptExchangeRequest(String requestId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.put(
        ApiEndpoints.acceptExchangeRequest(requestId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> declineExchangeRequest(String requestId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.delete(
        ApiEndpoints.declineExchangeRequest(requestId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }
}
