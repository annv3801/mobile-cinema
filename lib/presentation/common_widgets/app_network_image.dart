import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? radius;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? errorWidget;

  const AppNetworkImage(
    this.url, {
    super.key,
    this.radius,
    this.fit,
    this.width,
    this.height,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: url,
        width: width,
        height: height,
        errorWidget: (context, url, error) =>
            errorWidget ??
            SizedBox(
              width: width ?? 150.w,
              height: height ?? 150.w,
              child: const Center(child: Icon(Icons.error)),
            ),
        placeholder: (context, url) => SizedBox(
          width: width ?? 150.w,
          height: height ?? 150.w,
          child: const Center(child: AppLoadingIndicator()),
        ),
      ),
    );
  }
}
