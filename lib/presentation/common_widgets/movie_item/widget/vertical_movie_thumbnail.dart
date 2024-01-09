import 'package:cinemax/presentation/common_widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class VerticalMovieThumbnail extends StatelessWidget {
  final String url;
  final double width;

  const VerticalMovieThumbnail({
    super.key,
    required this.url,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final radius = width / 15;
    const ratio = 77 / 57;

    return AppNetworkImage(
      url,
      width: width,
      height: width * ratio,
      radius: radius,
      fit: BoxFit.cover,
    );
  }
}
