import 'package:json_annotation/json_annotation.dart';

part 'get_list_groups_request.g.dart';

@JsonSerializable()
class GetListGroupsRequest {
  final int currentPage;
  final int pageSize;

  const GetListGroupsRequest({
    required this.currentPage,
    required this.pageSize,
  });

  factory GetListGroupsRequest.fromJson(Map<String, dynamic> json) => _$GetListGroupsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetListGroupsRequestToJson(this);
}