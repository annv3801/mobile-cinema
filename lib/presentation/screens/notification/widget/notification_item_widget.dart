import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/domain/models/response/notifications/notification_response.dart';
import 'package:cinemax/presentation/common_widgets/app_network_image.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationResponse item;

  const NotificationItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 36.w,
      margin: EdgeInsets.only(bottom: 10.h, top: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppNetworkImage(item.imageUrl, width: 80.w, height: 100.h, fit: BoxFit.cover),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(item.title, fontSize: 14.sp, fontWeight: FontWeight.w700, color: AppColors.black),
                SizedBox(height: 5.h),
                AppText(item.shortDescription, fontSize: 12.sp, color: AppColors.gray62),
                SizedBox(height: 10.h),
                // AppText(
                //   DateTimeUtils.formatTimestamp(item.createdDate, DateTimeUtils.hourMinute),
                //   fontSize: 12.sp,
                //   color: AppColors.gray9F,
                //   fontWeight: FontWeight.w300,
                // ),
              ],
            ),
          ),
          if (!item.isRead)
            Container(
              width: 10.w,
              height: 10.w,
              margin: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w), color: AppColors.main),
            ),
        ],
      ),
    );
  }
}
