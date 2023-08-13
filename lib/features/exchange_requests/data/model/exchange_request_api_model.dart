import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/exchange_request_entity.dart';

part 'exchange_request_api_model.g.dart';

final exchangeRequestApiModelProvider = Provider<ExchangeRequestApiModel>(
    (ref) => const ExchangeRequestApiModel.empty());

@JsonSerializable()
class ExchangeRequestApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? exchangeRequestId;
  final Map<String, dynamic>? requester;
  final Map<String, dynamic>? requestedBook;
  final String? proposalBookTitle;
  final String? proposalBookAuthor;
  final String? proposalBookCover;
  final String proposalBook;
  final String? requestedUser;
  final String? status;
  final String message;
  final String? formattedCreatedAt;

  const ExchangeRequestApiModel({
    this.exchangeRequestId,
    this.requester,
    this.requestedBook,
    this.proposalBookTitle,
    this.proposalBookAuthor,
    this.proposalBookCover,
    required this.proposalBook,
    this.requestedUser,
    this.status,
    required this.message,
    this.formattedCreatedAt,
  });

  const ExchangeRequestApiModel.empty()
      : exchangeRequestId = '',
        requester = const {},
        requestedBook = const {},
        proposalBookTitle = '',
        proposalBookAuthor = '',
        proposalBookCover = '',
        proposalBook = '',
        requestedUser = '',
        status = '',
        message = '',
        formattedCreatedAt = '';

  // Convert API Object to Entity
  ExchangeRequestEntity toEntity() => ExchangeRequestEntity(
        exchangeRequestId: exchangeRequestId ?? '',
        requester: requester,
        requestedBook: requestedBook,
        proposalBookTitle: proposalBookTitle,
        proposalBookAuthor: proposalBookAuthor,
        proposalBookCover: proposalBookCover,
        proposalBook: proposalBook,
        requestedUser: requestedUser,
        status: status,
        message: message,
        formattedCreatedAt: formattedCreatedAt,
      );

  // Convert Entity to API Object
  ExchangeRequestApiModel fromEntity(ExchangeRequestEntity entity) =>
      ExchangeRequestApiModel(
        exchangeRequestId: entity.exchangeRequestId,
        requester: entity.requester,
        requestedBook: entity.requestedBook,
        proposalBookTitle: entity.proposalBookTitle,
        proposalBookAuthor: entity.proposalBookAuthor,
        proposalBookCover: entity.proposalBookCover,
        proposalBook: entity.proposalBook,
        requestedUser: entity.requestedUser,
        status: entity.status,
        message: entity.message,
        formattedCreatedAt: entity.formattedCreatedAt,
      );

  // Convert API List to Entity List
  List<ExchangeRequestEntity> toEntityList(
          List<ExchangeRequestApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        exchangeRequestId,
        requester,
        requestedBook,
        proposalBookTitle,
        proposalBookAuthor,
        proposalBookCover,
        proposalBook,
        requestedUser,
        status,
        message,
        formattedCreatedAt,
      ];

  factory ExchangeRequestApiModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRequestApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRequestApiModelToJson(this);
}
