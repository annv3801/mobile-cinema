part of 'cinemas_cubit.dart';

class CinemasState extends Equatable {
  final LoadStatus getListCinemasStatus;
  final List<CinemaResponse> listCinemas;
  final String? getListCinemasMessage;
  final LoadStatus getMoreCinemasStatus;
  final int total;
  final int currentPage;
  final bool hasNextPage;

  const CinemasState({
    this.getListCinemasStatus = LoadStatus.initial,
    this.listCinemas = const [],
    this.getListCinemasMessage,
    this.getMoreCinemasStatus = LoadStatus.initial,
    this.total = 0,
    this.currentPage = 1,
    this.hasNextPage = false,
  });

  CinemasState copyWith({
    LoadStatus? getListCinemasStatus,
    List<CinemaResponse>? listCinemas,
    String? getListCinemasMessage,
    LoadStatus? getMoreCinemasStatus,
    int? total,
    int? currentPage,
    bool? hasNextPage,
  }) {
    return CinemasState(
      getListCinemasStatus: getListCinemasStatus ?? this.getListCinemasStatus,
      listCinemas: listCinemas ?? this.listCinemas,
      getListCinemasMessage: getListCinemasMessage ?? this.getListCinemasMessage,
      getMoreCinemasStatus: getMoreCinemasStatus ?? this.getMoreCinemasStatus,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
        getListCinemasStatus,
        listCinemas,
        getListCinemasMessage,
        getMoreCinemasStatus,
        total,
        currentPage,
        hasNextPage,
      ];
}
