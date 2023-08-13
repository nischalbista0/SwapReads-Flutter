// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_exchange_requests_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetExchangeRequestsDTO _$GetExchangeRequestsDTOFromJson(
        Map<String, dynamic> json) =>
    GetExchangeRequestsDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              ExchangeRequestApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetExchangeRequestsDTOToJson(
        GetExchangeRequestsDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
