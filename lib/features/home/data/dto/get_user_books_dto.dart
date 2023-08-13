import 'package:json_annotation/json_annotation.dart';
import 'package:swapreads/features/home/data/model/home_api_model.dart';

part 'get_user_books_dto.g.dart';

@JsonSerializable()
class GetUserBooksDTO {
  final List<HomeApiModel> data;

  GetUserBooksDTO({
    required this.data,
  });

  factory GetUserBooksDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserBooksDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserBooksDTOToJson(this);
}
