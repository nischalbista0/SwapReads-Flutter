// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRequestApiModel _$ExchangeRequestApiModelFromJson(
        Map<String, dynamic> json) =>
    ExchangeRequestApiModel(
      exchangeRequestId: json['_id'] as String?,
      requester: json['requester'] as Map<String, dynamic>?,
      requestedBook: json['requestedBook'] as Map<String, dynamic>?,
      proposalBookTitle: json['proposalBookTitle'] as String?,
      proposalBookAuthor: json['proposalBookAuthor'] as String?,
      proposalBookCover: json['proposalBookCover'] as String?,
      proposalBook: json['proposalBook'] as String,
      requestedUser: json['requestedUser'] as String?,
      status: json['status'] as String?,
      message: json['message'] as String,
      formattedCreatedAt: json['formattedCreatedAt'] as String?,
    );

Map<String, dynamic> _$ExchangeRequestApiModelToJson(
        ExchangeRequestApiModel instance) =>
    <String, dynamic>{
      '_id': instance.exchangeRequestId,
      'requester': instance.requester,
      'requestedBook': instance.requestedBook,
      'proposalBookTitle': instance.proposalBookTitle,
      'proposalBookAuthor': instance.proposalBookAuthor,
      'proposalBookCover': instance.proposalBookCover,
      'proposalBook': instance.proposalBook,
      'requestedUser': instance.requestedUser,
      'status': instance.status,
      'message': instance.message,
      'formattedCreatedAt': instance.formattedCreatedAt,
    };
