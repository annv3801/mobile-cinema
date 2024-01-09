import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentMessageDialog extends Dialog {
  final BuildContext context;
  final Widget? icon;
  final Widget? action;
  final VoidCallback? onClose;

  ContentMessageDialog({
    Key? key,
    required this.context,
    required String title,
    String? content,
    Widget? buildContent,
    this.icon,
    this.action,
    this.onClose,
  }) : super(
          key: key,
          insetPadding: EdgeInsets.all(16.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
          child: Stack(
            children: [
              Container(
                width: 1.sw - 32.w,
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h, right: 18.w, left: 18.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      icon,
                      SizedBox(height: 10.h),
                    ],
                    AppText(title, fontSize: 17.sp, fontWeight: FontWeight.bold, color: AppColors.black, textAlign: TextAlign.center),
                    SizedBox(height: 8.h),
                    if (content != null) AppText(content, fontSize: 15.sp, color: AppColors.gray4D, textAlign: TextAlign.center),
                    if (buildContent != null) buildContent,
                    if (action != null) Padding(padding: EdgeInsets.only(top: 20.h), child: action),
                  ],
                ),
              ),
              if (onClose != null)
                Positioned(
                  top: 8.w,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      onClose.call();
                    },
                    child: Assets.icons.icClose.svg(width: 20.w, height: 20.w),
                  ),
                )
            ],
          ),
        );
}

class AppDialog {
  static void showCustomDialog(
    BuildContext context, {
    required String title,
    String? content,
    VoidCallback? onClose,
    Widget? action,
    Widget? buildContent,
    bool isDismiss = true,
    Widget? icon,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isDismiss,
      builder: (context) => PopScope(
        canPop: isDismiss,
        // onPopInvoked: (canPop) {
        //   if (isDismiss && onClose == null) {
        //     Navigator.of(context).pop();
        //   }
        //
        //   onClose?.call();
        // },
        child: ContentMessageDialog(
          title: title,
          content: content,
          icon: icon,
          buildContent: buildContent,
          action: action,
          context: context,
          onClose: onClose,
        ),
      ),
    );
  }

  static void showSuccessDialog(
    BuildContext context, {
    required String title,
    String? content,
    VoidCallback? onClose,
    Widget? action,
    Widget? buildContent,
    bool isDismiss = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isDismiss,
      builder: (context) => PopScope(
        canPop: isDismiss,
        child: ContentMessageDialog(
          title: title,
          content: content,
          icon: Assets.icons.icSuccess.svg(width: 55.w, height: 55.w),
          buildContent: buildContent,
          action: action,
          context: context,
          onClose: onClose,
        ),
      ),
    );
  }

  static void showFailureDialog(
    BuildContext context, {
    required String title,
    String? content,
    VoidCallback? onClose,
    Widget? action,
    Widget? buildContent,
    bool isDismiss = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isDismiss,
      builder: (context) => PopScope(
        canPop: isDismiss,
        child: ContentMessageDialog(
          title: title,
          content: content,
          icon: Assets.icons.icFailure.svg(width: 55.w, height: 55.w),
          buildContent: buildContent,
          action: action,
          context: context,
          onClose: onClose,
        ),
      ),
    );
  }

// static void showDatePickerDialog(
//   BuildContext context, {
//   required String title,
//   required DateTime value,
//   bool isDismiss = true,
//   Function(DateTime dateTime)? onAgree,
// }) {
//   DateTime selectedDate = value;
//
//   showDialog(
//     context: context,
//     barrierDismissible: isDismiss,
//     builder: (context) => Dialog(
//       insetPadding: EdgeInsets.all(16.w),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AppText(title, fontSize: 17.sp, fontWeight: FontWeight.bold, color: AppColors.black, textAlign: TextAlign.center),
//             SizedBox(height: 5.h),
//             CustomizableDatePickerWidget(
//               looping: true,
//               initialDate: value,
//               dateFormat: "dd-MM-yyyy",
//               pickerTheme: DateTimePickerTheme(
//                 itemTextStyle: GoogleFonts.manrope(color: AppColors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
//                 backgroundColor: AppColors.white,
//                 itemHeight: 50.h,
//                 pickerHeight: 150.h,
//                 dividerTheme: DatePickerDividerTheme(dividerColor: AppColors.greyD8, height: 2.h),
//               ),
//               onChange: (dateTime, selectedIndex) => selectedDate = dateTime,
//             ),
//             SizedBox(height: 5.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 AppButton(
//                   width: (1.sw - 72.w) / 2,
//                   title: tr("cancel"),
//                   color: AppColors.white,
//                   borderColor: AppColors.gray9F,
//                   fontWeight: FontWeight.w600,
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 SizedBox(width: 10.w),
//                 AppButton(
//                   width: (1.sw - 72.w) / 2,
//                   title: tr("agree"),
//                   color: AppColors.main,
//                   textColor: AppColors.white,
//                   fontWeight: FontWeight.w600,
//                   onPressed: () {
//                     onAgree?.call(selectedDate);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
