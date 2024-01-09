import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/domain/models/arguments/cinemas_arguments.dart';
import 'package:cinemax/domain/models/arguments/movie_detail_arguments.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_dialog.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/movie_detail/movie_detail_cubit.dart';
import 'package:cinemax/presentation/screens/movie_detail/widget/movie_detail_description_widget.dart';
import 'package:cinemax/presentation/screens/movie_detail/widget/movie_detail_header_widget.dart';
import 'package:cinemax/presentation/screens/movie_detail/widget/movie_detail_rating_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments arguments;

  const MovieDetailScreen({super.key, required this.arguments});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<MovieDetailCubit>(context);
    _cubit.getMovieDetail(widget.arguments.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MovieDetailCubit, MovieDetailState>(
          listenWhen: (previous, current) => previous.favoriteMovieStatus != current.favoriteMovieStatus,
          listener: (_, state) {
            if (state.favoriteMovieStatus == LoadStatus.failure && state.favoriteMovieMessage?.isNotEmpty == true) {
              AppDialog.showFailureDialog(
                context,
                title: tr("errorTitle"),
                content: state.favoriteMovieMessage,
                action: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: AppButton(
                    title: tr("agree"),
                    fontSize: 14.sp,
                    color: AppColors.main,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w600,
                    height: 40.h,
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.settings.name == RouteName.cinemaDetail);
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: AppPage(
        appBar: AppHeaderBar(
          actions: [
            BlocBuilder<MovieDetailCubit, MovieDetailState>(
              buildWhen: (previous, current) =>
                  previous.favoriteMovieStatus != current.favoriteMovieStatus ||
                  previous.getMovieDetailStatus != current.getMovieDetailStatus ||
                  previous.isFavorite != current.isFavorite,
              builder: (context, state) {
                if (state.getMovieDetailStatus == LoadStatus.loading) {
                  return const SizedBox();
                }

                if (state.favoriteMovieStatus == LoadStatus.loading) {
                  return AppLoadingIndicator(sizeLoading: 20.r);
                }

                return GestureDetector(
                  onTap: () {
                    _cubit.favoriteMovie(widget.arguments.movieId);
                  },
                  child: state.isFavorite
                      ? Assets.icons.icFavoriteFilled.svg(width: 20.r, height: 20.r)
                      : Assets.icons.icFavoriteOutlined.svg(width: 20.r, height: 20.r),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          buildWhen: (previous, current) =>
              previous.getMovieDetailStatus != current.getMovieDetailStatus || previous.movieDetail != current.movieDetail,
          builder: (context, state) {
            if (state.getMovieDetailStatus == LoadStatus.loading) {
              return Center(child: AppLoadingIndicator(sizeLoading: 40.r));
            }

            if (state.getMovieDetailStatus == LoadStatus.failure) {
              return Center(
                child: AppText(
                  state.getMovieDetailMessage ?? "",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state.getMovieDetailStatus == LoadStatus.success) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          MovieDetailHeaderWidget(movieDetail: state.movieDetail!),
                          SizedBox(height: 20.h),
                          MovieDetailDescription(description: state.movieDetail!.description),
                          SizedBox(height: 20.h),
                          MovieDetailRatingWidget(
                            movieId: widget.arguments.movieId,
                            movieRatings: state.movieDetail!.ratings,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: AppButton(
                      title: tr("bookNow"),
                      color: AppColors.main,
                      fontSize: 14.sp,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w700,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          RouteName.chooseCinema,
                          arguments: CinemasArguments(movieId: widget.arguments.movieId),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? 25.h : 10.h),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
