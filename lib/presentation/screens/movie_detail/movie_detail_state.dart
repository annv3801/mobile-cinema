part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  // movie detail
  final LoadStatus getMovieDetailStatus;
  final MovieDetailResponse? movieDetail;
  final String? getMovieDetailMessage;

  // favorite
  final LoadStatus favoriteMovieStatus;
  final bool isFavorite;
  final String? favoriteMovieMessage;

  // rating
  final LoadStatus ratingMovieStatus;
  final String? ratingMovieMessage;

  const MovieDetailState({
    // movie detail
    this.getMovieDetailStatus = LoadStatus.initial,
    this.movieDetail,
    this.getMovieDetailMessage,

    // favorite
    this.favoriteMovieStatus = LoadStatus.initial,
    this.isFavorite = false,
    this.favoriteMovieMessage,

    // rating
    this.ratingMovieStatus = LoadStatus.initial,
    this.ratingMovieMessage,
  });

  MovieDetailState copyWith({
    // movie detail
    LoadStatus? getMovieDetailStatus,
    MovieDetailResponse? movieDetail,
    String? getMovieDetailMessage,

    // favorite
    LoadStatus? favoriteMovieStatus,
    bool? isFavorite,
    String? favoriteMovieMessage,

    // rating
    LoadStatus? ratingMovieStatus,
    String? ratingMovieMessage,
  }) {
    return MovieDetailState(
      // movie detail
      getMovieDetailStatus: getMovieDetailStatus ?? this.getMovieDetailStatus,
      movieDetail: movieDetail ?? this.movieDetail,
      getMovieDetailMessage: getMovieDetailMessage,

      // favorite
      favoriteMovieStatus: favoriteMovieStatus ?? this.favoriteMovieStatus,
      isFavorite: isFavorite ?? this.isFavorite,
      favoriteMovieMessage: favoriteMovieMessage,

      // rating
      ratingMovieStatus: ratingMovieStatus ?? this.ratingMovieStatus,
      ratingMovieMessage: ratingMovieMessage,
    );
  }

  @override
  List<Object?> get props => [
        // movie detail
        getMovieDetailStatus,
        movieDetail,
        getMovieDetailMessage,

        // favorite
        favoriteMovieStatus,
        isFavorite,
        favoriteMovieMessage,

        // rating
        ratingMovieStatus,
        ratingMovieMessage,
      ];
}
