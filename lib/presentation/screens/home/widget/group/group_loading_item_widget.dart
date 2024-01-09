import 'package:cinemax/presentation/common_widgets/movie_item/vertical_movie_loading_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class GroupLoadingItemWidget extends StatelessWidget {
  const GroupLoadingItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SkeletonLine(style: SkeletonLineStyle(height: 15.h, width: 150.w, borderRadius: BorderRadius.circular(4.w))),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          width: 1.sw,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  child: const VerticalMovieLoadingItemWidget(),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
