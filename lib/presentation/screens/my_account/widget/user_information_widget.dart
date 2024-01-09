import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_network_image.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class UserInformationWidget extends StatefulWidget {
  const UserInformationWidget({super.key});

  @override
  State<UserInformationWidget> createState() => _UserInformationWidgetState();
}

class _UserInformationWidgetState extends State<UserInformationWidget> {
  final _cubit = getIt<MyAccountCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAccountCubit, MyAccountState>(
      bloc: _cubit,
      buildWhen: (prev, curr) => prev.getUserProfileStatus != curr.getUserProfileStatus || prev.userProfile != curr.userProfile,
      builder: (context, state) {
        if (state.getUserProfileStatus == LoadStatus.loading) {
          return Container(
            width: 1.sw - 32.w,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(vertical: 15.h),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.greyF5, width: 1.r)),
              color: AppColors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonAvatar(style: SkeletonAvatarStyle(shape: BoxShape.circle, width: 50.r, height: 50.r)),
                SizedBox(width: 10.h),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          width: 150.w,
                          height: 15.h,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          width: 100.w,
                          height: 15.h,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }

        if (state.getUserProfileStatus == LoadStatus.success && state.userProfile != null) {
          return Container(
            width: 1.sw - 32.w,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(vertical: 15.h),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.greyF5, width: 1.r)),
              color: AppColors.white,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppNetworkImage(
                    state.userProfile!.avatarUrl,
                    fit: BoxFit.cover,
                    width: 50.r,
                    height: 50.r,
                    radius: 100.w,
                    errorWidget: Assets.images.imgUser.image(width: 50.r, height: 50.r),
                  ),
                  SizedBox(width: 10.h),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          state.userProfile!.fullName,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                        SizedBox(height: 5.h),
                        AppText(
                          state.userProfile!.email,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gray4D,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
