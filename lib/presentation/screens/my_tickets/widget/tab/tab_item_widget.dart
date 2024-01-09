import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabItemWidget extends StatelessWidget {
  final String label;
  final bool isSelected;

  const TabItemWidget({super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (1.sw - 30.w) / 3,
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? AppColors.main : AppColors.greyEE,
            width: isSelected ? 3.w : 1.w,
          ),
        ),
      ),
      child: Center(
        child: AppText(
          label,
          color: isSelected ? AppColors.main : AppColors.gray9F,
          fontSize: 14.5.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
