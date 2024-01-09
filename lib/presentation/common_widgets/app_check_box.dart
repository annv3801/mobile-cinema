import 'package:cinemax/application/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckBox extends StatelessWidget {
  final VoidCallback? onChanged;
  final bool isChecked;
  final double? iconSize;
  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final double? borderRadius;
  final double size;

  const AppCheckBox({
    Key? key,
    this.isChecked = false,
    this.onChanged,
    this.iconSize,
    required this.activeColor,
    required this.checkColor,
    required this.borderColor,
    required this.size,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: isChecked ? activeColor : AppColors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 16.w),
          border: Border.all(color: isChecked ? activeColor : borderColor, width: 2.w),
        ),
        width: size,
        height: size,
        child: isChecked ? Icon(Icons.check, color: checkColor, size: iconSize ?? (size - 4.w)) : null,
      ),
    );
  }
}
