import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? userId;
  final String username;
  final String fullname;
  final String email;
  final String? phoneNumber;
  final String? bio;
  final String? image;
  // final List<dynamic>? exchangedRequest;
  // final List<dynamic>? bookmarkedBooks;

  const ProfileEntity({
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

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
        userId: json["userId"],
        username: json["username"],
        fullname: json["fullname"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        bio: json["bio"],
        image: json["image"],
        // exchangedRequest: json["exchangedRequest"],
        // bookmarkedBooks: json["bookmarkedBooks"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "fullname": fullname,
        "email": email,
        "phoneNumber": phoneNumber,
        "bio": bio,
        "image": image,
        // "exchangedRequest": exchangedRequest,
        // "bookmarkedBooks": bookmarkedBooks,
      };

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
}
