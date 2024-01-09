import 'package:cinemax/data/data_sources/api/api_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_movies_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetListMoviesRequest {
  final int currentPage;
  final int pageSize;
  final List<SearchByFieldsRequest>? searchByFields;

  const GetListMoviesRequest({
    required this.currentPage,
    required this.pageSize,
    this.searchByFields,
  });

  factory GetListMoviesRequest.fromJson(Map<String, dynamic> json) => _$GetListMoviesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetListMoviesRequestToJson(this);
}