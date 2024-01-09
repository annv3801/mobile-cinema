import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/domain/models/response/movies/movie_detail_response.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/widget/vertical_movie_thumbnail.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieInformationWidget extends StatelessWidget {
  final MovieDetailResponse movieInfo;

  const MovieInformationWidget({super.key, required this.movieInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalMovieThumbnail(width: 80.w, url: movieInfo.thumbnailUrl),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                movieInfo.name.toUpperCase(),
                fontSize: 14.sp,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 3.h),
              AppText(
                movieInfo.genre,
                fontSize: 12.sp,
                color: AppColors.gray9F,
                fontWeight: FontWeight.w500,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  text: "",
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Assets.icons.icStarSelected.svg(width: 15.r, height: 15.r),
                    ),
                    WidgetSpan(child: SizedBox(width: 5.w)),
                    TextSpan(text: "${movieInfo.totalRating} (${movieInfo.ratings.countStar} ${tr("rating")})"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
