import 'package:cinemax/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalRatingWidget extends StatelessWidget {
  final double totalRating;
  final double? size;

  const TotalRatingWidget({
    Key? key,
    required this.totalRating,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? 18.w;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (totalRating - (index + 1) >= 0) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            child: Assets.icons.icStarSelected.svg(width: iconSize, height: iconSize),
          );
        }

        if (totalRating - (index + 1) > -1) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            child: Assets.icons.icStarHalf.svg(width: iconSize, height: iconSize),
          );
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          child: Assets.icons.icStarUnselected.svg(width: iconSize, height: iconSize),
        );
      }),
    );
  }
}
