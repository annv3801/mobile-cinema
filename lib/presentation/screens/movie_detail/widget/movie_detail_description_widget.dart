import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetailDescription extends StatefulWidget {
  final String description;

  const MovieDetailDescription({super.key, required this.description});

  @override
  State<MovieDetailDescription> createState() => _MovieDetailDescriptionState();
}

class _MovieDetailDescriptionState extends State<MovieDetailDescription> {
  final showFullDescription = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    if (widget.description.isNotEmpty) {
      return Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(tr("description"), fontSize: 15.sp, fontWeight: FontWeight.w700, color: AppColors.black),
            SizedBox(height: 10.h),
            Builder(builder: (_) {
              if (widget.description.length > 200) {
                return ValueListenableBuilder(
                  valueListenable: showFullDescription,
                  builder: (_, value, __) => RichText(
                    text: TextSpan(
                      text: value ? widget.description : "${widget.description.substring(0, 200)} ...",
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () {
                              showFullDescription.value = !showFullDescription.value;
                            },
                            child: AppText(
                              " ${value ? tr("collapse") : tr("viewMore")}",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.main,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return AppText(
                widget.description,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              );
            }),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
