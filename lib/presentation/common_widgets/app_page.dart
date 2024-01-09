import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPage extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final bool isLoading;
  final Widget body;
  final VoidCallback? onPressedBack;
  final Color? backgroundColor;

  const AppPage({
    super.key,
    this.appBar,
    this.isLoading = false,
    required this.body,
    this.onPressedBack,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appBar,
          backgroundColor: backgroundColor ?? AppColors.white,
          body: body,
        ),
        isLoading ? _buildFullLoading(context) : const SizedBox(),
      ],
    );
  }

  Widget _buildFullLoading(context) {
    return Positioned(
      width: 1.sw,
      height: 1.sh,
      child: Container(
        color: Colors.black54,
        child: const Center(child: AppLoadingIndicator()),
      ),
    );
  }
}
