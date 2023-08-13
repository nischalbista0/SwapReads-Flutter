// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileApiModel _$ProfileApiModelFromJson(Map<String, dynamic> json) =>
    ProfileApiModel(
      userId: json['_id'] as String?,
      username: json['username'] as String,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      bio: json['bio'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ProfileApiModelToJson(ProfileApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'username': instance.username,
      'fullname': instance.fullname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'bio': instance.bio,
      'image': instance.image,
    };
