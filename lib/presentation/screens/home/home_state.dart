part of 'home_cubit.dart';

class HomeState extends Equatable {
  // slider
  final LoadStatus getCarouselSliderStatus;
  final List<CarouselSliderResponse> listCarouselSlider;

  // group
  final LoadStatus getListGroupsStatus;
  final List<GroupResponse> listGroups;

  // movies by group
  final LoadStatus getListMoviesByGroupStatus;
  final List<MovieResponse> listMoviesByGroup;

  // news
  final LoadStatus getListNewsStatus;
  final List<NewsResponse> listNews;
  final LoadStatus getMoreNewsStatus;
  final int currentPage;
  final bool hasNextPage;

  const HomeState({
    // slider
    this.getCarouselSliderStatus = LoadStatus.initial,
    this.listCarouselSlider = const [],

    // group
    this.getListGroupsStatus = LoadStatus.initial,
    this.listGroups = const [],

    // movies by group
    this.getListMoviesByGroupStatus = LoadStatus.initial,
    this.listMoviesByGroup = const [],

    // news
    this.getListNewsStatus = LoadStatus.initial,
    this.listNews = const [],
    this.getMoreNewsStatus = LoadStatus.initial,
    this.currentPage = 1,
    this.hasNextPage = false,
  });

  HomeState copyWith({
    // slider
    LoadStatus? getCarouselSliderStatus,
    List<CarouselSliderResponse>? listCarouselSlider,

    // group
    LoadStatus? getListGroupsStatus,
    List<GroupResponse>? listGroups,

    // movies by group
    LoadStatus? getListMoviesByGroupStatus,
    List<MovieResponse>? listMoviesByGroup,

    // news
    LoadStatus? getListNewsStatus,
    List<NewsResponse>? listNews,
    LoadStatus? getMoreNewsStatus,
    int? currentPage,
    bool? hasNextPage,
  }) {
    return HomeState(
      // slider
      getCarouselSliderStatus: getCarouselSliderStatus ?? this.getCarouselSliderStatus,
      listCarouselSlider: listCarouselSlider ?? this.listCarouselSlider,

      // group
      getListGroupsStatus: getListGroupsStatus ?? this.getListGroupsStatus,
      listGroups: listGroups ?? this.listGroups,

      // movies by group
      getListMoviesByGroupStatus: getListMoviesByGroupStatus ?? this.getListMoviesByGroupStatus,
      listMoviesByGroup: listMoviesByGroup ?? this.listMoviesByGroup,

      // news
      getListNewsStatus: getListNewsStatus ?? this.getListNewsStatus,
      listNews: listNews ?? this.listNews,
      getMoreNewsStatus: getMoreNewsStatus ?? this.getMoreNewsStatus,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object> get props => [
        // slider
        getCarouselSliderStatus,
        listCarouselSlider,

        // group
        getListGroupsStatus,
        listGroups,

        // movies by group
        getListMoviesByGroupStatus,
        listMoviesByGroup,

        // news
        getListNewsStatus,
        listNews,
        getMoreNewsStatus,
        currentPage,
        hasNextPage,
      ];
}
