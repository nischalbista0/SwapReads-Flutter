import 'package:json_annotation/json_annotation.dart';

import '../model/home_api_model.dart';

part 'get_book_by_id_dto.g.dart';

@JsonSerializable()
class GetBookByIdDTO {
  final List<HomeApiModel> data;

  GetBookByIdDTO({
    required this.data,
  });

  factory GetBookByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetBookByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetBookByIdDTOToJson(this);
}
