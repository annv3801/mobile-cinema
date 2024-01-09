import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_network_image.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({super.key});

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  final _accountCubit = getIt<MyAccountCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: Row(
        children: [
          BlocBuilder<MyAccountCubit, MyAccountState>(
            bloc: _accountCubit,
            buildWhen: (previous, current) => previous.getUserProfileStatus != current.getUserProfileStatus,
            builder: (context, state) {
              if (state.getUserProfileStatus == LoadStatus.loading) {
                return SkeletonAvatar(style: SkeletonAvatarStyle(shape: BoxShape.circle, width: 45.w, height: 45.w));
              }

              if (state.getUserProfileStatus == LoadStatus.success && state.userProfile != null) {
                return AppNetworkImage(
                  state.userProfile!.avatarUrl,
                  fit: BoxFit.cover,
                  width: 45.w,
                  height: 45.w,
                  radius: 100.w,
                  errorWidget: Assets.images.imgUser.image(width: 45.w, height: 45.w),
                );
              }

              return Assets.images.imgUser.image(width: 45.w, height: 45.w);
            },
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(tr("yourLocation"), fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.gray4D),
                SizedBox(height: 4.h),
                AppText(
                  "Hà Nội",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
