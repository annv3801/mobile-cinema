import 'package:json_annotation/json_annotation.dart';

part 'get_list_news_request.g.dart';

@JsonSerializable()
class GetListNewsRequest {
  final int currentPage;
  final int pageSize;

  const GetListNewsRequest({
    required this.currentPage,
    required this.pageSize,
  });

  factory GetListNewsRequest.fromJson(Map<String, dynamic> json) => _$GetListNewsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetListNewsRequestToJson(this);
}