import 'package:cinemax/application/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class ListCinemasLoadingWidget extends StatelessWidget {
  const ListCinemasLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) => _buildCinemaLoadingItem(),
      separatorBuilder: (context, index) => Container(
        width: 1.sw - 30.w,
        color: AppColors.greyEE,
        height: 1.w,
      ),
      itemCount: 4,
    );
  }

  Widget _buildCinemaLoadingItem() {
    return Container(
      width: 1.sw - 30.w,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
              width: 20.w,
              height: 20.w,
              borderRadius: BorderRadius.circular(20.w),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: SkeletonLine(
              style: SkeletonLineStyle(
                width: double.infinity,
                height: 20.w,
                borderRadius: BorderRadius.circular(8.w),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          SkeletonLine(
            style: SkeletonLineStyle(
              width: 20.w,
              height: 20.w,
              borderRadius: BorderRadius.circular(20.w),
            ),
          ),
        ],
      ),
    );
  }
}
