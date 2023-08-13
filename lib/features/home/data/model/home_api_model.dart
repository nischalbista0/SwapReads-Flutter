import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/book_entity.dart';

part 'home_api_model.g.dart';

final homeApiModelProvider =
    Provider<HomeApiModel>((ref) => HomeApiModel.empty());

@JsonSerializable()
class HomeApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? bookId;
  final String title;
  final String author;
  final String description;
  final String genre;
  final String language;
  final String? bookCover;
  final String? date;
  final String? formattedCreatedAt;
  final bool? isBookmarked;
  final Map<String, dynamic>? user;

  const HomeApiModel({
    this.bookId,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.language,
    this.bookCover,
    this.date,
    this.formattedCreatedAt,
    this.isBookmarked,
    this.user,
  });

  HomeApiModel.empty()
      : bookId = '',
        title = '',
        author = '',
        description = '',
        genre = '',
        language = '',
        bookCover = '',
        date = '',
        formattedCreatedAt = '',
        isBookmarked = false,
        user = {};

  // Convert API Object to Entity
  BookEntity toEntity() => BookEntity(
        bookId: bookId ?? '',
        title: title,
        author: author,
        description: description,
        genre: genre,
        language: language,
        bookCover: bookCover,
        date: date,
        formattedCreatedAt: formattedCreatedAt ?? '',
        isBookmarked: isBookmarked ?? false,
        user: user,
      );

  // Convert Entity to API Object
  HomeApiModel fromEntity(BookEntity entity) => HomeApiModel(
        bookId: bookId ?? '',
        title: title,
        author: author,
        description: description,
        genre: genre,
        language: language,
        bookCover: bookCover,
        date: date,
        formattedCreatedAt: formattedCreatedAt,
        isBookmarked: isBookmarked,
        user: user,
      );

  // Convert API List to Entity List
  List<BookEntity> toEntityList(List<HomeApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        bookId,
        title,
        author,
        description,
        genre,
        language,
        bookCover,
        date,
        formattedCreatedAt,
        isBookmarked,
        user,
      ];

  factory HomeApiModel.fromJson(Map<String, dynamic> json) =>
      _$HomeApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeApiModelToJson(this);
}
