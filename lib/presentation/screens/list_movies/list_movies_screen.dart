import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/domain/models/arguments/list_movies_arguments.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_load_more.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/vertical_movie_item.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/vertical_movie_loading_item.dart';
import 'package:cinemax/presentation/screens/list_movies/list_movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListMoviesScreen extends StatefulWidget {
  final ListMoviesArguments arguments;

  const ListMoviesScreen({super.key, required this.arguments});

  @override
  State<ListMoviesScreen> createState() => _ListMoviesScreenState();
}

class _ListMoviesScreenState extends State<ListMoviesScreen> {
  late ListMoviesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ListMoviesCubit>(context);
    _cubit.getListMovies(widget.arguments.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppHeaderBar(title: widget.arguments.title),
      body: SafeArea(
        child: SizedBox(
          width: 1.sw,
          child: AppLoadMore(
            onRefresh: () {
              _cubit.getListMovies(widget.arguments.groupId);
            },
            onLoadMore: () {
              _cubit.getMoreListMovies(widget.arguments.groupId);
            },
            child: BlocBuilder<ListMoviesCubit, ListMoviesState>(
              buildWhen: (previous, current) =>
                  previous.getListMoviesStatus != current.getListMoviesStatus ||
                  previous.getMoreMoviesStatus != current.getMoreMoviesStatus,
              builder: (context, state) {
                if (state.getListMoviesStatus == LoadStatus.loading) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Column(
                      children: List.generate(2, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              Expanded(child: VerticalMovieLoadingItemWidget(width: (1.sw - 45.w) / 2)),
                              SizedBox(width: 12.w),
                              Expanded(child: VerticalMovieLoadingItemWidget(width: (1.sw - 45.w) / 2)),
                            ],
                          ),
                        );
                      }),
                    ),
                  );
                }

                if (state.getListMoviesStatus == LoadStatus.success) {
                  final length = (state.listMovies.length / 2).ceil();

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(length, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: VerticalMovieItem(
                                      width: (1.sw - 45.w) / 2,
                                      item: state.listMovies[index * 2],
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: index * 2 + 2 > state.listMovies.length
                                        ? const SizedBox()
                                        : VerticalMovieItem(
                                            width: (1.sw - 45.w) / 2,
                                            item: state.listMovies[index * 2 + 1],
                                          ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        if (state.getMoreMoviesStatus == LoadStatus.loading)
                          Container(
                            margin: EdgeInsets.only(top: 15.h),
                            child: const AppLoadingIndicator(),
                          ),
                      ],
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
