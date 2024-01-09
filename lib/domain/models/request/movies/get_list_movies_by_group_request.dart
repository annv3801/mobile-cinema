import 'package:json_annotation/json_annotation.dart';

part 'get_list_movies_by_group_request.g.dart';

@JsonSerializable()
class GetListMoviesByGroupRequest {
  final int groupId;
  final int currentPage;
  final int pageSize;

  const GetListMoviesByGroupRequest({
    required this.groupId,
    required this.currentPage,
    required this.pageSize,
  });

  factory GetListMoviesByGroupRequest.fromJson(Map<String, dynamic> json) => _$GetListMoviesByGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetListMoviesByGroupRequestToJson(this);
}