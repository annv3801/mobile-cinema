import 'package:json_annotation/json_annotation.dart';

part 'api_request.g.dart';

@JsonSerializable()
class SearchByFieldsRequest {
  final String searchFieldName;
  final dynamic searchValue;

  const SearchByFieldsRequest({
    required this.searchFieldName,
    required this.searchValue,
  });

  factory SearchByFieldsRequest.fromJson(Map<String, dynamic> json) => _$SearchByFieldsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchByFieldsRequestToJson(this);
}
