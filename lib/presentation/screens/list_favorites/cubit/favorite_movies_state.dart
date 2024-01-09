part of 'favorite_movies_cubit.dart';

class FavoriteMoviesState extends Equatable {
  final LoadStatus getListMoviesStatus;
  final List<MovieResponse> listMovies;
  final String? getListMoviesMessage;
  final LoadStatus getMoreMoviesStatus;
  final int total;
  final int currentPage;
  final bool hasNextPage;

  const FavoriteMoviesState({
    this.getListMoviesStatus = LoadStatus.initial,
    this.listMovies = const [],
    this.getListMoviesMessage,
    this.getMoreMoviesStatus = LoadStatus.initial,
    this.total = 0,
    this.currentPage = 1,
    this.hasNextPage = false,
  });

  FavoriteMoviesState copyWith({
    LoadStatus? getListMoviesStatus,
    List<MovieResponse>? listMovies,
    String? getListMoviesMessage,
    LoadStatus? getMoreMoviesStatus,
    int? total,
    int? currentPage,
    bool? hasNextPage,
  }) {
    return FavoriteMoviesState(
      getListMoviesStatus: getListMoviesStatus ?? this.getListMoviesStatus,
      listMovies: listMovies ?? this.listMovies,
      getListMoviesMessage: getListMoviesMessage ?? this.getListMoviesMessage,
      getMoreMoviesStatus: getMoreMoviesStatus ?? this.getMoreMoviesStatus,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
    getListMoviesStatus,
    listMovies,
    getListMoviesMessage,
    getMoreMoviesStatus,
    total,
    currentPage,
    hasNextPage,
  ];
}
