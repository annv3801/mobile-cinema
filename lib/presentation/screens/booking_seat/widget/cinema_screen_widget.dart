import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();

    path.moveTo(0, height);
    path.lineTo(0, height * 0.4);
    path.quadraticBezierTo(width * 0.5, 0, width, height * 0.4);
    path.lineTo(width, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CinemaScreenWidget extends StatelessWidget {
  const CinemaScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      color: AppColors.greyF5,
      child: Stack(
        children: [
          ClipPath(
            clipper: Clipper(),
            child: Container(
              width: 1.sw - 48.w,
              height: 100.h,
              color: AppColors.main,
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: Clipper(),
              child: Container(
                width: 1.sw - 48.w,
                height: 90.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFEBE9),
                      Color(0xFFFFF0EF),
                      Color(0xFFFFF5F5),
                      AppColors.greyF5,
                    ],
                  ),
                ),
                child: Center(
                  child: AppText(
                    tr("screen"),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray62,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
