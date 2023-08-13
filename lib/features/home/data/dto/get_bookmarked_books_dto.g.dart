// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bookmarked_books_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookmarkedBooksDTO _$GetBookmarkedBooksDTOFromJson(
        Map<String, dynamic> json) =>
    GetBookmarkedBooksDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => HomeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBookmarkedBooksDTOToJson(
        GetBookmarkedBooksDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
