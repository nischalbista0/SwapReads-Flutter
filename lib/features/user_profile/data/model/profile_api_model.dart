import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/profile_entity.dart';

part 'profile_api_model.g.dart';

final profileApiModelProvider =
    Provider<ProfileApiModel>((ref) => const ProfileApiModel.empty());

@JsonSerializable()
class ProfileApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String username;
  final String fullname;
  final String email;
  final String? phoneNumber;
  final String? bio;
  final String? image;
  // final List<dynamic>? exchangedRequest;
  // final List<dynamic>? bookmarkedBooks;

  const ProfileApiModel({
    this.userId,
    required this.username,
    required this.fullname,
    required this.email,
    this.phoneNumber,
    this.bio,
    this.image,
    // this.exchangedRequest,
    // this.bookmarkedBooks,
  });

  const ProfileApiModel.empty()
      : userId = '',
        username = '',
        fullname = '',
        email = '',
        phoneNumber = '',
        bio = '',
        image = '';
  // exchangedRequest = const [],
  // bookmarkedBooks = const [];

  // Convert API Object to Entity
  ProfileEntity toEntity() => ProfileEntity(
        userId: userId ?? '',
        username: username,
        fullname: fullname,
        email: email,
        phoneNumber: phoneNumber,
        bio: bio,
        image: image,
        // exchangedRequest: exchangedRequest,
        // bookmarkedBooks: bookmarkedBooks,
      );

  // Convert Entity to API Object
  ProfileApiModel fromEntity(ProfileEntity entity) => ProfileApiModel(
        userId: userId ?? '',
        username: username,
        fullname: fullname,
        email: email,
        phoneNumber: phoneNumber,
        bio: bio,
        image: image,
        // exchangedRequest: exchangedRequest,
        // bookmarkedBooks: bookmarkedBooks,
      );

  // Convert API List to Entity List
  List<ProfileEntity> toEntityList(List<ProfileApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        userId,
        username,
        fullname,
        email,
        phoneNumber,
        bio,
        image,
        // exchangedRequest,
        // bookmarkedBooks,
      ];

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileApiModelToJson(this);
}
