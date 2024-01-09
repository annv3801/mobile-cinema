import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/widget/vertical_movie_thumbnail_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class ListSchedulerLoadingWidget extends StatelessWidget {
  const ListSchedulerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(2, (index) => _buildSchedulerItemLoading()),
    );
  }

  Widget _buildSchedulerItemLoading() {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(15.w),
      color: AppColors.white,
      child: Column(
        children: [
          _buildMovieInfoLoading(),
          SizedBox(height: 10.h),
          _buildListRoomLoading(),
        ],
      ),
    );
  }

  Widget _buildMovieInfoLoading() {
    final width = (1.sw - 30.w) * 0.4;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalMovieThumbnailLoading(width: width),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLine(style: SkeletonLineStyle(height: 18.h, width: double.infinity, borderRadius: BorderRadius.circular(4.r))),
              SizedBox(height: 15.h),
              SkeletonLine(style: SkeletonLineStyle(height: 15.h, width: 150.w, borderRadius: BorderRadius.circular(4.r))),
              SizedBox(height: 8.h),
              SkeletonLine(style: SkeletonLineStyle(height: 15.h, width: 150.w, borderRadius: BorderRadius.circular(4.r))),
              SizedBox(height: 8.h),
              SkeletonLine(style: SkeletonLineStyle(height: 15.h, width: 150.w, borderRadius: BorderRadius.circular(4.r))),
              SizedBox(height: 8.h),
              SkeletonLine(style: SkeletonLineStyle(height: 15.h, width: 150.w, borderRadius: BorderRadius.circular(4.r))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListRoomLoading() => Column(
        children: List.generate(2, (index) => _buildRoomLoadingItem()),
      );

  Widget _buildRoomLoadingItem() => Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLine(style: SkeletonLineStyle(height: 20.h, width: 100.w, borderRadius: BorderRadius.circular(4.r))),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 15.w,
              runSpacing: 15.w,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 80.w,
                  height: 40.h,
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
}
