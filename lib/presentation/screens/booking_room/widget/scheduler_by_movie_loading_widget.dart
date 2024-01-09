import 'package:cinemax/application/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class SchedulerByMovieLoadingWidget extends StatelessWidget {
  const SchedulerByMovieLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(15.w),
      color: AppColors.white,
      child: Column(
        children: List.generate(2, (index) => _buildRoomLoadingItem()),
      ),
    );
  }

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
