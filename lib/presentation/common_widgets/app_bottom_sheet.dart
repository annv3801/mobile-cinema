import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomSheet {
  static void showCustomBottomSheet(
    BuildContext context, {
    String? title,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxHeight: 1.sh - 200.h),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12.r),
          topLeft: Radius.circular(12.r),
        ),
      ),
      builder: (_) => Container(
        width: 1.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            topLeft: Radius.circular(12.r),
          ),
          color: AppColors.white,
        ),
        padding: EdgeInsets.fromLTRB(16.w, 15.h, 16.w, 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              AppText(
                title,
                fontSize: 16.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
            Container(
              width: double.infinity,
              height: 0.5.h,
              color: AppColors.greyD8,
              margin: EdgeInsets.symmetric(vertical: 16.h),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
