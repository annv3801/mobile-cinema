import 'package:cinemax/data/data_sources/api/api_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_cinemas_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetListCinemasRequest {
  final int currentPage;
  final int pageSize;
  final List<SearchByFieldsRequest>? searchByFields;

  const GetListCinemasRequest({
    required this.currentPage,
    required this.pageSize,
    this.searchByFields,
  });

  factory GetListCinemasRequest.fromJson(Map<String, dynamic> json) => _$GetListCinemasRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetListCinemasRequestToJson(this);
}