import 'package:json_annotation/json_annotation.dart';

import '../model/home_api_model.dart';

part 'get_all_books_dto.g.dart';

@JsonSerializable()
class GetAllBooksDTO {
  final List<HomeApiModel> data;

  GetAllBooksDTO({
    required this.data,
  });

  factory GetAllBooksDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllBooksDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllBooksDTOToJson(this);
}
