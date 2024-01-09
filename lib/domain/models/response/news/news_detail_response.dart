import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_detail_response.g.dart';

@JsonSerializable()
class NewsDetailResponse {
  final String title;
  final String description;
  final String content;
  final DateTime? createdTime;

  String get refactorContent {
    final list = content.split('"');
    final result = list.map((element) {
      if (element.contains("height:") && element.contains("width:")) {
        final data = element.split(";");
        final Map<String, dynamic> map = {};
        for (var i = 0; i < data.length; i++) {
          final refactorData = data[i].split(":").map((item) => "\"${item.trim()}\"").join(":");
          map.addAll(jsonDecode("{$refactorData}"));
        }

        final width = num.parse((map["width"] as String).replaceAll("px", ""));
        final height = num.parse((map["height"] as String).replaceAll("px", ""));

        String result = element;
        final widthContent = 1.sw - 32.w;
        result = result.replaceAll("${width}px", "${widthContent}px");
        result = result.replaceAll("${height}px", "${widthContent * height / width}px");

        return result;
      }
      return element;
    }).toList();

    return result.join('"');
  }

  const NewsDetailResponse({
    this.title = "",
    this.description = "",
    this.content = "",
    this.createdTime,
  });

  factory NewsDetailResponse.fromJson(Map<String, dynamic> json) => _$NewsDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDetailResponseToJson(this);
}
