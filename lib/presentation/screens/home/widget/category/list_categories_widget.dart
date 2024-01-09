import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCategoriesWidget extends StatefulWidget {
  const ListCategoriesWidget({super.key});

  @override
  State<ListCategoriesWidget> createState() => _ListCategoriesWidgetState();
}

class _ListCategoriesWidgetState extends State<ListCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  tr("category"),
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
                GestureDetector(
                  onTap: () {},
                  child: AppText(
                    tr("viewAll"),
                    fontSize: 14.sp,
                    color: AppColors.main,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            scrollDirection: Axis.horizontal,
            child: Row(),
          )
        ],
      ),
    );
  }
}
