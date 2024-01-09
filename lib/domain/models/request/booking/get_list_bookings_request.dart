import 'package:cinemax/application/enums/booking_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_bookings_request.g.dart';

@JsonSerializable()
class GetListBookingsRequest {
  @JsonKey(name: "AccountId")
  final int accountId;

  @JsonKey(name: "CurrentPage")
  final int currentPage;

  @JsonKey(name: "PageSize")
  final int pageSize;

  final List<SortByFieldsRequest> sortByFields;

  @JsonKey(name: "tab")
  final BookingStatus? status;

  const GetListBookingsRequest({
    required this.accountId,
    required this.currentPage,
    required this.pageSize,
    this.sortByFields = const [],
    this.status,
  });

  factory GetListBookingsRequest.fromJson(Map<String, dynamic> json) => _$GetListBookingsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetListBookingsRequestToJson(this);
}

@JsonSerializable()
class SortByFieldsRequest {
  final String colName;
  final String sortDirection;

  const SortByFieldsRequest({required this.colName, required this.sortDirection});

  factory SortByFieldsRequest.fromJson(Map<String, dynamic> json) => _$SortByFieldsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SortByFieldsRequestToJson(this);
}
