import 'package:json_annotation/json_annotation.dart';

part 'get_list_categories_request.g.dart';

@JsonSerializable()
class GetListCategoriesRequest {
  final int currentPage;
  final int pageSize;

  const GetListCategoriesRequest({
    required this.currentPage,
    required this.pageSize,
  });

  factory GetListCategoriesRequest.fromJson(Map<String, dynamic> json) => _$GetListCategoriesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetListCategoriesRequestToJson(this);
}