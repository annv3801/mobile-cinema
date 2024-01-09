import 'package:json_annotation/json_annotation.dart';

part 'group_response.g.dart';

@JsonSerializable()
class GroupResponse {
  final int id;
  final int index;
  final String title;

  const GroupResponse({
    this.id = 0,
    this.index = 0,
    this.title = "",
  });

  factory GroupResponse.fromJson(Map<String, dynamic> json) => _$GroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupResponseToJson(this);
}
