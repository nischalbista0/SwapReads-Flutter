// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeApiModel _$HomeApiModelFromJson(Map<String, dynamic> json) => HomeApiModel(
      bookId: json['_id'] as String?,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      genre: json['genre'] as String,
      language: json['language'] as String,
      bookCover: json['bookCover'] as String?,
      date: json['date'] as String?,
      formattedCreatedAt: json['formattedCreatedAt'] as String?,
      isBookmarked: json['isBookmarked'] as bool?,
      user: json['user'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$HomeApiModelToJson(HomeApiModel instance) =>
    <String, dynamic>{
      '_id': instance.bookId,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'genre': instance.genre,
      'language': instance.language,
      'bookCover': instance.bookCover,
      'date': instance.date,
      'formattedCreatedAt': instance.formattedCreatedAt,
      'isBookmarked': instance.isBookmarked,
      'user': instance.user,
    };
