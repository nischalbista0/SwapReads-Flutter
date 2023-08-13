import 'package:json_annotation/json_annotation.dart';

import '../model/exchange_request_api_model.dart';

part 'get_exchange_requests_dto.g.dart';

@JsonSerializable()
class GetExchangeRequestsDTO {
  final List<ExchangeRequestApiModel> data;

  GetExchangeRequestsDTO({
    required this.data,
  });

  factory GetExchangeRequestsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetExchangeRequestsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetExchangeRequestsDTOToJson(this);
}

