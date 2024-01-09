part of 'list_movies_cubit.dart';

class ListMoviesState extends Equatable {
  final LoadStatus getListMoviesStatus;
  final List<MovieResponse> listMovies;
  final LoadStatus getMoreMoviesStatus;
  final int currentPage;
  final bool hasNextPage;

  const ListMoviesState({
    this.getListMoviesStatus = LoadStatus.initial,
    this.listMovies = const [],
    this.getMoreMoviesStatus = LoadStatus.initial,
    this.currentPage = 1,
    this.hasNextPage = false,
  });

  ListMoviesState copyWith({
    LoadStatus? getListMoviesStatus,
    List<MovieResponse>? listMovies,
    LoadStatus? getMoreMoviesStatus,
    int? currentPage,
    bool? hasNextPage,
  }) {
    return ListMoviesState(
      getListMoviesStatus: getListMoviesStatus ?? this.getListMoviesStatus,
      listMovies: listMovies ?? this.listMovies,
      getMoreMoviesStatus: getMoreMoviesStatus ?? this.getMoreMoviesStatus,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object> get props => [
        getListMoviesStatus,
        listMovies,
        getMoreMoviesStatus,
        currentPage,
        hasNextPage,
      ];
}
