part of 'cinema_detail_cubit.dart';

class CinemaDetailState extends Equatable {
  // cinema detail
  final LoadStatus getCinemaDetailStatus;
  final CinemaDetailResponse? cinemaDetail;
  final String? getCinemaDetailMessage;
  final List<Marker> markers;

  // favorite
  final bool isFavorite;
  final LoadStatus favoriteCinemaStatus;
  final String? favoriteCinemaMessage;

  // scheduler
  final LoadStatus getListSchedulersStatus;
  final List<SchedulerCinemaResponse> listCinemaSchedulers;
  final String? getListSchedulersMessage;
  final int? schedulerId;
  final int? movieId;

  // list booking date
  final List<DateTime> listBookingDate;
  final DateTime bookingDate;

  const CinemaDetailState({
    // cinema detail
    this.getCinemaDetailStatus = LoadStatus.initial,
    this.cinemaDetail,
    this.getCinemaDetailMessage,
    this.markers = const [],

    // favorite
    this.isFavorite = false,
    this.favoriteCinemaStatus = LoadStatus.initial,
    this.favoriteCinemaMessage,

    // scheduler
    this.getListSchedulersStatus = LoadStatus.initial,
    this.listCinemaSchedulers = const [],
    this.getListSchedulersMessage,
    this.schedulerId,
    this.movieId,

    // list booking date
    this.listBookingDate = const [],
    required this.bookingDate,
  });

  CinemaDetailState copyWith({
    // cinema detail
    LoadStatus? getCinemaDetailStatus,
    CinemaDetailResponse? cinemaDetail,
    String? getCinemaDetailMessage,
    List<Marker>? markers,

    // favorite
    bool? isFavorite,
    LoadStatus? favoriteCinemaStatus,
    String? favoriteCinemaMessage,

    // scheduler
    LoadStatus? getListSchedulersStatus,
    List<SchedulerCinemaResponse>? listCinemaSchedulers,
    String? getListSchedulersMessage,
    int? schedulerId,
    int? movieId,

    // list booking date
    List<DateTime>? listBookingDate,
    DateTime? bookingDate,
  }) {
    return CinemaDetailState(
      // cinema detail
      getCinemaDetailStatus: getCinemaDetailStatus ?? this.getCinemaDetailStatus,
      cinemaDetail: cinemaDetail ?? this.cinemaDetail,
      getCinemaDetailMessage: getCinemaDetailMessage,
      markers: markers ?? this.markers,

      // favorite
      isFavorite: isFavorite ?? this.isFavorite,
      favoriteCinemaStatus: favoriteCinemaStatus ?? this.favoriteCinemaStatus,
      favoriteCinemaMessage: favoriteCinemaMessage,

      // scheduler
      getListSchedulersStatus: getListSchedulersStatus ?? this.getListSchedulersStatus,
      listCinemaSchedulers: listCinemaSchedulers ?? this.listCinemaSchedulers,
      getListSchedulersMessage: getListSchedulersMessage,
      schedulerId: schedulerId ?? this.schedulerId,
      movieId: movieId ?? this.movieId,

      // list booking date
      listBookingDate: listBookingDate ?? this.listBookingDate,
      bookingDate: bookingDate ?? this.bookingDate,
    );
  }

  @override
  List<Object?> get props => [
        // cinema detail
        getCinemaDetailStatus,
        cinemaDetail,
        getCinemaDetailMessage,
        markers,

        // favorite
        isFavorite,
        favoriteCinemaStatus,
        favoriteCinemaMessage,

        // scheduler
        getListSchedulersStatus,
        listCinemaSchedulers,
        getListSchedulersMessage,
        schedulerId,
        movieId,

        // list booking date
        listBookingDate,
        bookingDate,
      ];
}
