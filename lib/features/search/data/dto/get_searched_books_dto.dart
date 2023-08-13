import 'package:json_annotation/json_annotation.dart';

import '../../../home/data/model/home_api_model.dart';

part 'get_searched_books_dto.g.dart';

@JsonSerializable()
class GetSearchedBooksDTO {
  final List<HomeApiModel> data;

  GetSearchedBooksDTO({
    required this.data,
  });

  factory GetSearchedBooksDTO.fromJson(Map<String, dynamic> json) =>
      _$GetSearchedBooksDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetSearchedBooksDTOToJson(this);
}
