import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/domain/models/response/movies/movie_rating_response.dart';
import 'package:cinemax/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/common_widgets/total_star_rating.dart';
import 'package:cinemax/presentation/screens/movie_detail/movie_detail_cubit.dart';
import 'package:cinemax/presentation/screens/movie_detail/widget/rating_movie_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieDetailRatingWidget extends StatefulWidget {
  final int movieId;
  final MovieRatingResponse movieRatings;

  const MovieDetailRatingWidget({super.key, required this.movieId, required this.movieRatings});

  @override
  State<MovieDetailRatingWidget> createState() => _MovieDetailRatingWidgetState();
}

class _MovieDetailRatingWidgetState extends State<MovieDetailRatingWidget> {
  void showRatingBottomSheet() {
    AppBottomSheet.showCustomBottomSheet(
      context,
      title: tr("rating"),
      child: BlocProvider.value(
        value: context.read<MovieDetailCubit>(),
        child: RatingMovieBottomSheet(movieId: widget.movieId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(tr("rating"), fontSize: 15.sp, fontWeight: FontWeight.w700, color: AppColors.black),
          SizedBox(height: 10.h),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRatingSummary(),
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    final pointValue = 5 - index;

                    return Container(
                      margin: EdgeInsets.only(bottom: 5.h),
                      child: _buildRatingProgressBar(
                        point: pointValue,
                        percent: widget.movieRatings.getPercentByPoint(pointValue),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          AppButton(
            width: double.infinity,
            height: 38.h,
            title: tr("rateNow"),
            color: AppColors.white,
            textColor: AppColors.main,
            borderColor: AppColors.main,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            onPressed: () {
              showRatingBottomSheet();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Container(
      padding: EdgeInsets.only(right: 10.w),
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(border: Border(right: BorderSide(color: AppColors.greyD8, width: 1.w))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            widget.movieRatings.totalRating.toString(),
            fontSize: 50.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          SizedBox(height: 8.h),
          TotalRatingWidget(totalRating: widget.movieRatings.totalRating),
          SizedBox(height: 6.h),
          AppText(
            "${widget.movieRatings.countStar} ${tr("rating")}",
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.gray62,
          ),
        ],
      ),
    );
  }

  Widget _buildRatingProgressBar({required int point, required double percent}) {
    final total = 1.sw - 190.w;
    final value = total * percent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: AppText(point.toString(), fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.gray62)),
        Stack(
          children: [
            Container(
              width: total,
              height: 5.h,
              decoration: BoxDecoration(color: AppColors.greyEE, borderRadius: BorderRadius.circular(4.w)),
            ),
            Container(
              width: value,
              height: 5.h,
              decoration: BoxDecoration(color: AppColors.main, borderRadius: BorderRadius.circular(4.w)),
            ),
          ],
        ),
      ],
    );
  }
}
