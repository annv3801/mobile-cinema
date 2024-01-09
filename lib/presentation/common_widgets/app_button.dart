import 'package:cinemax/application/utils/utils.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Color color;
  final Widget? icon;
  final bool isEnable;
  final double fontSize;
  final Color textColor;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;
  final double? radius;
  final VoidCallback? onPressed;
  final Color? borderColor;

  const AppButton({
    Key? key,
    required this.title,
    required this.color,
    this.icon,
    this.isEnable = true,
    required this.fontSize,
    required this.textColor,
    this.fontWeight,
    this.width,
    this.height,
    this.radius,
    this.onPressed,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable ? 1 : 0.6,
      child: GestureDetector(
        onTap: () {
          Utils.dismissKeyboard();
          if (!isEnable) return;
          onPressed?.call();
        },
        child: Container(
          width: width ?? 343.w,
          height: height ?? 48.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius ?? 100.w),
            border: Border.all(color: borderColor ?? color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(width: 4.w),
              ],
              AppText(title, fontSize: fontSize, color: textColor, fontWeight: fontWeight),
            ],
          ),
        ),
      ),
    );
  }
}
