import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/domain/models/request/movies/rating_movie_request.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_dialog.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/movie_detail/movie_detail_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingMovieBottomSheet extends StatefulWidget {
  final int movieId;

  const RatingMovieBottomSheet({super.key, required this.movieId});

  @override
  State<RatingMovieBottomSheet> createState() => _RatingMovieBottomSheetState();
}

class _RatingMovieBottomSheetState extends State<RatingMovieBottomSheet> {
  final point = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieDetailCubit, MovieDetailState>(
      listenWhen: (prev, curr) => prev.ratingMovieStatus != curr.ratingMovieStatus,
      listener: (context, state) {
        if (state.ratingMovieStatus == LoadStatus.loading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => PopScope(
              canPop: false,
              child: Center(child: AppLoadingIndicator(sizeLoading: 30.r)),
            ),
          );
        }

        if (state.ratingMovieStatus == LoadStatus.failure) {
          Navigator.of(context).pop();
          AppDialog.showFailureDialog(
            context,
            title: tr("ratingFailed"),
            content: state.ratingMovieMessage,
            action: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: AppButton(
                title: tr("agree"),
                fontSize: 13.sp,
                color: AppColors.main,
                textColor: AppColors.white,
                fontWeight: FontWeight.w600,
                height: 40.h,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        }

        if (state.ratingMovieStatus == LoadStatus.success) {
          Navigator.of(context).popUntil((route) => route.settings.name == RouteName.movieDetail);
          AppDialog.showSuccessDialog(
            context,
            title: tr("ratingSuccess"),
            content: tr("ratingSuccessContent"),
          );
        }
      },
      child: Column(
        children: [
          AppText(
            tr("ratingTitle"),
            fontSize: 17.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ValueListenableBuilder(
              valueListenable: point,
              builder: (_, value, __) => Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    onTap: () {
                      point.value = index + 1;
                    },
                    child: Builder(
                      builder: (_) {
                        if (index + 1 <= value) {
                          return Assets.icons.icFavoriteFilled.svg(width: 30.r, height: 30.r);
                        }

                        return Assets.icons.icFavoriteOutlined.svg(width: 30.r, height: 30.r);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  title: tr("cancel"),
                  fontSize: 14.sp,
                  color: AppColors.pink,
                  textColor: AppColors.main,
                  fontWeight: FontWeight.w600,
                  height: 40.h,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: point,
                  builder: (_, value, __) => AppButton(
                    title: tr("rateNow"),
                    fontSize: 14.sp,
                    color: AppColors.main,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w600,
                    height: 40.h,
                    isEnable: value > 0,
                    onPressed: () {
                      final body = RatingMovieRequest(
                        movieId: widget.movieId,
                        rating: value,
                      );
                      context.read<MovieDetailCubit>().ratingMovie(body);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom > 0 ? 25.h : 10.h),
        ],
      ),
    );
  }
}
