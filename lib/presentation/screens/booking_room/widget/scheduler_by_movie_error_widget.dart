import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SchedulerByMovieErrorWidget extends StatelessWidget {
  final String message;

  const SchedulerByMovieErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.imgEmptyCinema.image(width: 0.4.sw),
          SizedBox(height: 10.h),
          AppText(
            message,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
