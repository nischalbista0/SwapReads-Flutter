// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_searched_books_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchedBooksDTO _$GetSearchedBooksDTOFromJson(Map<String, dynamic> json) =>
    GetSearchedBooksDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => HomeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSearchedBooksDTOToJson(
        GetSearchedBooksDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
