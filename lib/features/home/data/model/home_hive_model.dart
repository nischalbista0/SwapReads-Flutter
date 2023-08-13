import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swapreads/features/home/data/model/home_api_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/constants/hive_table_constants.dart';
import '../../domain/entity/book_entity.dart';

part 'home_hive_model.g.dart';

final homeHiveModelProvider = Provider((ref) => HomeHiveModel.empty());

@HiveType(typeId: HiveTableConstant.bookTableId)
class HomeHiveModel {
  @HiveField(0)
  final String bookId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String author;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String genre;
  @HiveField(5)
  final String language;
  @HiveField(6)
  final String? bookCover;
  @HiveField(7)
  final String? date;
  @HiveField(8)
  final Map<String, dynamic>? user;
  @HiveField(9)
  final String? formattedCreatedAt;
  @HiveField(10)
  final bool? isBookmarked;

  // empty constructor
  HomeHiveModel.empty()
      : bookId = '',
        title = '',
        author = '',
        description = '',
        genre = '',
        language = '',
        bookCover = '',
        date = '',
        user = {},
        formattedCreatedAt = '',
        isBookmarked = false;

  HomeHiveModel({
    String? bookId,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.language,
    this.bookCover,
    this.date,
    this.user,
    this.formattedCreatedAt,
    this.isBookmarked,
  }) : bookId = bookId ?? const Uuid().v4();

  // Convert Hive Object to Entity
  BookEntity toEntity() => BookEntity(
        bookId: bookId,
        title: title,
        author: author,
        description: description,
        genre: genre,
        language: language,
        bookCover: bookCover,
        date: date,
        user: user,
        formattedCreatedAt: formattedCreatedAt,
        isBookmarked: isBookmarked,
      );

  // Convert Entity to Hive Object
  HomeHiveModel toHiveModel(BookEntity entity) => HomeHiveModel(
        bookId: entity.bookId,
        title: entity.title,
        author: entity.author,
        description: entity.description,
        genre: entity.genre,
        language: entity.language,
        bookCover: entity.bookCover,
        date: entity.date,
        user: entity.user,
        formattedCreatedAt: entity.formattedCreatedAt,
        isBookmarked: entity.isBookmarked,
      );

  List<HomeHiveModel> fromApiModelList(List<HomeApiModel> apiModels) {
    return apiModels
        .map((apiModel) => HomeHiveModel(
              bookId: apiModel.bookId,
              title: apiModel.title,
              author: apiModel.author,
              description: apiModel.description,
              genre: apiModel.genre,
              language: apiModel.language,
              bookCover: apiModel.bookCover,
              date: apiModel.date,
              user: apiModel.user,
              formattedCreatedAt: apiModel.formattedCreatedAt,
              isBookmarked: apiModel.isBookmarked,
            ))
        .toList();
  }

  // Convert Hive List to Entity List
  List<BookEntity> toEntityList(List<HomeHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'HomeHiveModel(bookId: $bookId, title: $title, author: $author, description: $description, genre: $genre, language: $language, bookCover: $bookCover, date: $date, user: $user, formattedCreatedAt: $formattedCreatedAt, isBookmarked: $isBookmarked)';
  }
}
