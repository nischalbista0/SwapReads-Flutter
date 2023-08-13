import 'package:json_annotation/json_annotation.dart';
import 'package:swapreads/features/home/data/model/home_api_model.dart';

part 'get_bookmarked_books_dto.g.dart';

@JsonSerializable()
class GetBookmarkedBooksDTO {
  final List<HomeApiModel> data;

  GetBookmarkedBooksDTO({
    required this.data,
  });

  factory GetBookmarkedBooksDTO.fromJson(Map<String, dynamic> json) =>
      _$GetBookmarkedBooksDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetBookmarkedBooksDTOToJson(this);
}
