import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/domain/models/response/movies/movie_detail_response.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/widget/vertical_movie_thumbnail.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieDetailHeaderWidget extends StatelessWidget {
  final MovieDetailResponse movieDetail;

  const MovieDetailHeaderWidget({Key? key, required this.movieDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieWidth = (1.sw - 30.w) * 0.45;

    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalMovieThumbnail(
            width: movieWidth,
            url: movieDetail.thumbnailUrl,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  movieDetail.name.toUpperCase(),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                SizedBox(height: 15.h),
                _buildRow(label: tr("director"), value: movieDetail.director),
                SizedBox(height: 8.h),
                _buildRow(label: tr("genre"), value: movieDetail.genre),
                SizedBox(height: 8.h),
                _buildRow(label: tr("premiere"), value: movieDetail.premiere),
                SizedBox(height: 8.h),
                _buildRow(label: tr("duration"), value: "${movieDetail.duration} ${tr("minutes").toLowerCase()}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow({required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70.w,
          child: AppText(label, fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.gray62),
        ),
        AppText(" : ", fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.gray62),
        Expanded(child: AppText(value, fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.gray62)),
      ],
    );
  }
}
