import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final T? data;
  final bool success;
  final List<ErrorResponse> errors;
  final String message;

  const ApiResponse({
    this.data,
    this.success = false,
    this.errors = const [],
    this.message = "",
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$ApiResponseToJson(this, toJsonT);
}

@JsonSerializable()
class ErrorResponse {
  final String fieldName;
  final String error;

  const ErrorResponse({
    this.fieldName = "",
    this.error = "",
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class ListDataResponse<T> {
  final List<T> data;
  final int currentPage;
  final int pageSize;
  final int total;

  const ListDataResponse({
    this.data = const [],
    this.currentPage = 0,
    this.pageSize = 0,
    this.total = 0,
  });

  int get lastPage {
    if (total == 0 || pageSize == 0) return 0;

    return (total / pageSize).round() + 1;
  }

  factory ListDataResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ListDataResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$ListDataResponseToJson(this, toJsonT);
}
