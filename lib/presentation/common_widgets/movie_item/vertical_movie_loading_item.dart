import 'package:cinemax/application/constants/app_constants.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/widget/vertical_movie_thumbnail_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class VerticalMovieLoadingItemWidget extends StatelessWidget {
  final double? width;

  const VerticalMovieLoadingItemWidget({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    final movieWidth = width ?? 150.w;

    return SizedBox(
      width: movieWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalMovieThumbnailLoading(width: movieWidth),
          SizedBox(height: 8.h),
          SkeletonLine(
            style: SkeletonLineStyle(
              width: movieWidth,
              height: 15.h,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 3.h),
          SkeletonLine(
            style: SkeletonLineStyle(
              width: movieWidth * 0.7,
              height: 15.h,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}
