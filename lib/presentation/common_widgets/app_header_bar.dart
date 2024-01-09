import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showClose;
  final List<Widget>? actions;
  final double? height;
  final Color? color;
  final Color? backgroundColor;

  const AppHeaderBar({
    super.key,
    this.title,
    this.showClose = true,
    this.actions,
    this.height,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final contentColor = color ?? AppColors.black;

    return AppBar(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: backgroundColor ?? AppColors.white,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      title: SizedBox(
        width: 1.sw,
        height: height ?? 40.h,
        child: Stack(
          children: [
            Center(
              child: AppText(
                title ?? "",
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: contentColor,
              ),
            ),
            SizedBox(
              height: height ?? 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    if (showClose) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Assets.icons.icBack.svg(
                          width: 25.w,
                          height: 25.w,
                          colorFilter: ColorFilter.mode(contentColor, BlendMode.srcIn),
                        ),
                      );
                    }

                    return SizedBox(width: 10.w);
                  }),
                  Builder(builder: (context) {
                    if (actions != null) {
                      return Row(children: actions!);
                    }

                    return SizedBox(width: 10.w);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 40.h);
}
