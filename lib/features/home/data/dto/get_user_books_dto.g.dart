// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_books_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserBooksDTO _$GetUserBooksDTOFromJson(Map<String, dynamic> json) =>
    GetUserBooksDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => HomeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserBooksDTOToJson(GetUserBooksDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
