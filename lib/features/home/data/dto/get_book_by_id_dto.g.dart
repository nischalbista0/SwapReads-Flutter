// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_book_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookByIdDTO _$GetBookByIdDTOFromJson(Map<String, dynamic> json) =>
    GetBookByIdDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => HomeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBookByIdDTOToJson(GetBookByIdDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
