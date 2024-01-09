part of 'my_tickets_cubit.dart';

class MyTicketsState extends Equatable {
  final LoadStatus getListBookingStatus;
  final List<BookingResponse> listBookings;
  final String? getListBookingMessage;
  final LoadStatus getMoreListBookingStatus;
  final int currentPage;
  final bool hasNextPage;

  const MyTicketsState({
    this.getListBookingStatus = LoadStatus.initial,
    this.listBookings = const [],
    this.getListBookingMessage,
    this.getMoreListBookingStatus = LoadStatus.initial,
    this.currentPage = 0,
    this.hasNextPage = false,
  });

  MyTicketsState copyWith({
    LoadStatus? getListBookingStatus,
    List<BookingResponse>? listBookings,
    String? getListBookingMessage,
    LoadStatus? getMoreListBookingStatus,
    int? currentPage,
    bool? hasNextPage,
  }) {
    return MyTicketsState(
      getListBookingStatus: getListBookingStatus ?? this.getListBookingStatus,
      listBookings: listBookings ?? this.listBookings,
      getListBookingMessage: getListBookingMessage,
      getMoreListBookingStatus: getMoreListBookingStatus ?? this.getMoreListBookingStatus,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
        getListBookingStatus,
        listBookings,
        getListBookingMessage,
        getMoreListBookingStatus,
        currentPage,
        hasNextPage,
      ];
}
