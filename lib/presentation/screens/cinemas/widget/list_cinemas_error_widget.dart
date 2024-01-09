import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCinemasErrorWidget extends StatelessWidget {
  final String message;

  const ListCinemasErrorWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 0.1.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.imgEmptyCinema.image(width: 0.4.sw),
          SizedBox(height: 10.h),
          AppText(message, fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.gray62, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}