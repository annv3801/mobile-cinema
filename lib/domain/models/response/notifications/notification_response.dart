import 'package:cinemax/application/enums/notification_scene_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

@JsonSerializable(includeIfNull: false)
class NotificationResponse {
  final int id;
  final String title;
  final String shortDescription;
  final String imageUrl;
  final NotificationSceneId sceneId;
  final int sceneObjectId;
  final int createdDate;
  final bool isRead;

  const NotificationResponse({
    this.id = 0,
    this.title = "",
    this.shortDescription = "",
    this.imageUrl = "",
    required this.sceneId,
    this.sceneObjectId = 0,
    this.createdDate = 0,
    this.isRead = false,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
