part of 'booking_room_cubit.dart';

class BookingRoomState extends Equatable {
  // cinema detail
  final LoadStatus getCinemaDetailStatus;
  final CinemaDetailResponse? cinemaDetail;
  final String? getCinemaDetailMessage;
  final List<Marker> markers;
  final bool isFavorite;

  // list booking date
  final List<DateTime> listBookingDate;
  final DateTime bookingDate;

  // scheduler
  final LoadStatus getSchedulerDataStatus;
  final SchedulerDataResponse? schedulerData;
  final String? getSchedulerDataMessage;
  final int? schedulerId;

  const BookingRoomState({
    // cinema detail
    this.getCinemaDetailStatus = LoadStatus.initial,
    this.cinemaDetail,
    this.getCinemaDetailMessage,
    this.markers = const [],
    this.isFavorite = false,

    // list booking date
    this.listBookingDate = const [],
    required this.bookingDate,

    // scheduler
    this.getSchedulerDataStatus = LoadStatus.initial,
    this.schedulerData,
    this.getSchedulerDataMessage,
    this.schedulerId,
  });

  BookingRoomState copyWith({
    // cinema detail
    LoadStatus? getCinemaDetailStatus,
    CinemaDetailResponse? cinemaDetail,
    String? getCinemaDetailMessage,
    List<Marker>? markers,
    bool? isFavorite,

    // list booking date
    List<DateTime>? listBookingDate,
    DateTime? bookingDate,

    // scheduler
    LoadStatus? getSchedulerDataStatus,
    SchedulerDataResponse? schedulerData,
    String? getSchedulerDataMessage,
    int? schedulerId,
  }) {
    return BookingRoomState(
      // cinema detail
      getCinemaDetailStatus: getCinemaDetailStatus ?? this.getCinemaDetailStatus,
      cinemaDetail: cinemaDetail ?? this.cinemaDetail,
      getCinemaDetailMessage: getCinemaDetailMessage,
      markers: markers ?? this.markers,
      isFavorite: isFavorite ?? this.isFavorite,

      // list booking date
      listBookingDate: listBookingDate ?? this.listBookingDate,
      bookingDate: bookingDate ?? this.bookingDate,

      // scheduler
      getSchedulerDataStatus: getSchedulerDataStatus ?? this.getSchedulerDataStatus,
      schedulerData: schedulerData ?? this.schedulerData,
      getSchedulerDataMessage: getSchedulerDataMessage ?? this.getSchedulerDataMessage,
      schedulerId: schedulerId ?? this.schedulerId,
    );
  }

  @override
  List<Object?> get props => [
        // cinema detail
        getCinemaDetailStatus,
        cinemaDetail,
        getCinemaDetailMessage,
        markers,
        isFavorite,

        // list booking date
        listBookingDate,
        bookingDate,

        // scheduler
        getSchedulerDataStatus,
        schedulerData,
        getSchedulerDataMessage,
        schedulerId,
      ];
}
