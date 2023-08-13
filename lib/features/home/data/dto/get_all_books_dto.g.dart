// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_books_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllBooksDTO _$GetAllBooksDTOFromJson(Map<String, dynamic> json) =>
    GetAllBooksDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => HomeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllBooksDTOToJson(GetAllBooksDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
