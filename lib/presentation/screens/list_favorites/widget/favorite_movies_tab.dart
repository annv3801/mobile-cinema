import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/observers/route_observer.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_load_more.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/vertical_movie_item.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/vertical_movie_loading_item.dart';
import 'package:cinemax/presentation/screens/list_favorites/cubit/favorite_movies_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteMoviesTab extends StatefulWidget {
  const FavoriteMoviesTab({super.key});

  @override
  State<FavoriteMoviesTab> createState() => _FavoriteMoviesTabState();
}

class _FavoriteMoviesTabState extends State<FavoriteMoviesTab> with RouteAware {
  late FavoriteMoviesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<FavoriteMoviesCubit>(context);
    _cubit.getListFavoriteMovies();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _cubit.getListFavoriteMovies();
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteMoviesCubit, FavoriteMoviesState>(
      buildWhen: (previous, current) =>
          previous.getListMoviesStatus != current.getListMoviesStatus || previous.getMoreMoviesStatus != current.getMoreMoviesStatus,
      builder: (context, state) {
        if (state.getListMoviesStatus == LoadStatus.loading) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10.h),
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
          if (state.listMovies.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 0.2.sh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.images.imgEmptyCinema.image(width: 0.4.sw),
                  SizedBox(height: 10.h),
                  AppText(
                    tr("favoriteMovieIsEmpty"),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray62,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final length = (state.listMovies.length / 2).ceil();

          return AppLoadMore(
            onRefresh: () {
              _cubit.getListFavoriteMovies();
            },
            onLoadMore: () {
              _cubit.getMoreListFavoriteMovies();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10.h),
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
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
