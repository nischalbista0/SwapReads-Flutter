import 'package:equatable/equatable.dart';

class ExchangeRequestEntity extends Equatable {
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

  const ExchangeRequestEntity(
      {this.exchangeRequestId,
      this.requester,
      this.requestedBook,
      this.proposalBookTitle,
      this.proposalBookAuthor,
      this.proposalBookCover,
      required this.proposalBook,
      this.requestedUser,
      this.status,
      required this.message,
      this.formattedCreatedAt});

  factory ExchangeRequestEntity.fromJson(Map<String, dynamic> json) =>
      ExchangeRequestEntity(
          exchangeRequestId: json["_id"],
          requester: json["requester"],
          requestedBook: json["requestedBook"],
          proposalBookTitle: json["proposalBookData"]["title"],
          proposalBookAuthor: json["proposalBookData"]["author"],
          proposalBookCover: json["proposalBookData"]["bookCover"],
          proposalBook: json["proposalBook"],
          requestedUser: json["requestedUser"],
          status: json["status"],
          message: json["message"],
          formattedCreatedAt: json["formattedCreatedAt"]);

  Map<String, dynamic> toJson() => {
        "_id": exchangeRequestId,
        "requester": requester,
        "requestedBook": requestedBook,
        "proposalBookData": proposalBookTitle,
        "proposalBookAuthor": proposalBookAuthor,
        "proposalBookCover": proposalBookCover,
        "proposalBook": proposalBook,
        "requestedUser": requestedUser,
        "status": status,
        "message": message,
        "formattedCreatedAt": formattedCreatedAt
      };

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
        formattedCreatedAt
      ];
}
