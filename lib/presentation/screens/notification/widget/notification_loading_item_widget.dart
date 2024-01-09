import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class NotificationLoadingItemWidget extends StatelessWidget {
  const NotificationLoadingItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 36.w,
      margin: EdgeInsets.only(bottom: 10.h, top: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLine(style: SkeletonLineStyle(width: 80.w, height: 100.h, borderRadius: BorderRadius.circular(4.w))),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(style: SkeletonLineStyle(height: 15.h, width: 150.w, borderRadius: BorderRadius.circular(4.w))),
                SizedBox(height: 7.h),
                SkeletonLine(style: SkeletonLineStyle(height: 15.h, width: 1.sw - 156.w, borderRadius: BorderRadius.circular(4.w))),
                SizedBox(height: 7.h),
                SkeletonLine(style: SkeletonLineStyle(height: 15.h, width: 120.w, borderRadius: BorderRadius.circular(4.w))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
