import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class VerticalMovieThumbnailLoading extends StatelessWidget {
  final double width;

  const VerticalMovieThumbnailLoading({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    final radius = width / 15;
    const ratio = 77 / 57;

    return SkeletonLine(
      style: SkeletonLineStyle(
        width: width,
        height: width * ratio,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
