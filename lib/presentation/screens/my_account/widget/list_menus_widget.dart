import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/dto/menu_model.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_dialog.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListMenusWidget extends StatefulWidget {
  const ListMenusWidget({super.key});

  @override
  State<ListMenusWidget> createState() => _ListMenusWidgetState();
}

class _ListMenusWidgetState extends State<ListMenusWidget> {
  final _cubit = getIt<MyAccountCubit>();

  final _listMenu = [
    MenuModel(
      title: tr("personalInfo"),
      icon: Assets.icons.icUserOutlined,
      routeName: RouteName.informationForm,
    ),
    MenuModel(
      title: tr("listFavorite"),
      icon: Assets.icons.icFavoriteOutlined,
      routeName: RouteName.listFavorites,
    ),
    // MenuModel(
    //   title: tr("paymentMethods"),
    //   icon: Assets.icons.icPaymentMethod,
    //   routeName: '',
    // ),
    MenuModel(
      title: tr("language"),
      icon: Assets.icons.icLanguage,
      routeName: '',
    ),
  ];

  void showLogoutConfirmationDialog() {
    AppDialog.showCustomDialog(
      context,
      title: tr("logoutConfirmation"),
      action: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            Expanded(
              child: AppButton(
                title: tr("logout"),
                fontSize: 14.sp,
                color: AppColors.pink,
                textColor: AppColors.main,
                fontWeight: FontWeight.w600,
                height: 40.h,
                onPressed: () {
                  _cubit.logout();
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: AppButton(
                title: tr("cancel"),
                fontSize: 14.sp,
                color: AppColors.main,
                textColor: AppColors.white,
                fontWeight: FontWeight.w600,
                height: 40.h,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void showRemoveAccountConfirmationDialog() {
    AppDialog.showCustomDialog(
      context,
      title: tr("removeAccountConfirmation"),
      action: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            Expanded(
              child: AppButton(
                title: tr("delete"),
                fontSize: 14.sp,
                color: AppColors.pink,
                textColor: AppColors.main,
                fontWeight: FontWeight.w600,
                height: 40.h,
                onPressed: () {
                  _cubit.logout();
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: AppButton(
                title: tr("cancel"),
                fontSize: 14.sp,
                color: AppColors.main,
                textColor: AppColors.white,
                fontWeight: FontWeight.w600,
                height: 40.h,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            tr("settings"),
            fontSize: 15.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 10.h),
          Column(
            children: List.generate(
              _listMenu.length,
              (index) => _buildMenuItem(
                _listMenu[index],
                onTap: () {
                  if (_listMenu[index].routeName?.isNotEmpty == true) {
                    Navigator.of(context).pushNamed(_listMenu[index].routeName!);
                  }
                },
              ),
            ),
          ),
          _buildMenuItem(
            MenuModel(title: tr("deleteAccount"), icon: Assets.icons.icDelete),
            showArrow: false,
            onTap: showRemoveAccountConfirmationDialog,
          ),
          _buildMenuItem(
            MenuModel(title: tr("logout"), icon: Assets.icons.icLogout),
            color: AppColors.main,
            showArrow: false,
            onTap: showLogoutConfirmationDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    MenuModel item, {
    VoidCallback? onTap,
    Color? color,
    bool showArrow = true,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            item.icon.svg(
              width: 18.r,
              height: 18.r,
              colorFilter: ColorFilter.mode(
                color ?? AppColors.black,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: AppText(
                item.title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: color ?? AppColors.black,
              ),
            ),
            if (showArrow)
              SvgPicture.asset(
                Assets.icons.icArrowRight.path,
                width: 15.r,
                height: 15.r,
              ),
          ],
        ),
      ),
    );
  }
}
