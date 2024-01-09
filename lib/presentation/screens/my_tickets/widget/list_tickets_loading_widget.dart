import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/widget/vertical_movie_thumbnail_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class ListTicketsLoadingWidget extends StatelessWidget {
  const ListTicketsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 8.h),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => _buildLoadingItem(),
      ),
    );
  }

  Widget _buildLoadingItem() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        border: Border.all(width: 1.r, color: AppColors.greyEE),
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalMovieThumbnailLoading(width: 90.w),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                    width: double.infinity,
                    height: 15.h,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 3.h),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    width: double.infinity,
                    height: 15.h,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 10.w),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    width: 200.w,
                    height: 15.h,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
