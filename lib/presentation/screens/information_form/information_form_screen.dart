import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/response/user/user_response.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_dialog.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_label_text_field.dart';
import 'package:cinemax/presentation/common_widgets/app_network_image.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/information_form/information_form_cubit.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationFormScreen extends StatefulWidget {
  const InformationFormScreen({super.key});

  @override
  State<InformationFormScreen> createState() => _InformationFormScreenState();
}

class _InformationFormScreenState extends State<InformationFormScreen> {
  final _myAccountCubit = getIt<MyAccountCubit>();
  late InformationFormCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<InformationFormCubit>(context);
    _cubit.initFormData();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InformationFormCubit, InformationFormState>(
          listenWhen: (prev, curr) => prev.updateProfileStatus != curr.updateProfileStatus,
          listener: (_, state) {
            if (state.updateProfileStatus == LoadStatus.failure) {
              AppDialog.showFailureDialog(
                context,
                title: tr("errorTitle"),
                content: state.updateProfileMessage,
                action: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: AppButton(
                    title: tr("agree"),
                    fontSize: 14.sp,
                    color: AppColors.main,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w600,
                    height: 40.h,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }

            if (state.updateProfileStatus == LoadStatus.success) {
              Navigator.of(context).popUntil((route) => route.settings.name == RouteName.homeTab);
            }
          },
        ),
      ],
      child: BlocBuilder<InformationFormCubit, InformationFormState>(
        buildWhen: (prev, curr) => prev.updateProfileStatus != curr.updateProfileStatus,
        builder: (context, state) => AppPage(
          isLoading: state.updateProfileStatus == LoadStatus.loading,
          appBar: AppHeaderBar(title: tr("personalInfo")),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            BlocBuilder<InformationFormCubit, InformationFormState>(
                              buildWhen: (prev, curr) => prev.avatarPhoto != curr.avatarPhoto,
                              builder: (context, state) {
                                if (state.avatarPhoto != null) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: Image.file(
                                      state.avatarPhoto!,
                                      width: 100.r,
                                      height: 100.r,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }

                                return AppNetworkImage(
                                  _myAccountCubit.state.userProfile?.avatarUrl ?? "",
                                  fit: BoxFit.cover,
                                  width: 100.r,
                                  height: 100.r,
                                  radius: 100.r,
                                  errorWidget: Assets.images.imgUser.image(width: 80.r, height: 80.r),
                                );
                              },
                            ),
                            Positioned(
                              right: 5.r,
                              bottom: 5.r,
                              child: GestureDetector(
                                onTap: () {
                                  _cubit.onChangeAvatarPhoto();
                                },
                                child: Container(
                                  width: 20.r,
                                  height: 20.r,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: AppColors.main),
                                  child: Center(
                                    child: Assets.icons.icCamera.svg(
                                      width: 15.r,
                                      height: 15.r,
                                      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      BlocBuilder<InformationFormCubit, InformationFormState>(
                        buildWhen: (prev, curr) => prev.fullNameErrorMessage != curr.fullNameErrorMessage,
                        builder: (context, state) => AppLabelTextField(
                          label: tr("fullName"),
                          hintText: tr("fullNameHintText"),
                          defaultValue: _myAccountCubit.state.userProfile?.fullName ?? "",
                          errorMessage: state.fullNameErrorMessage,
                          onChanged: (value) {
                            _cubit.onChangeFullName(value);
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                      AppLabelTextField(
                        enable: false,
                        label: tr("phoneNumber"),
                        defaultValue: _myAccountCubit.state.userProfile?.phoneNumber ?? "",
                        prefixIcon: Assets.icons.icPhoneFilled.svg(
                          width: 20.w,
                          height: 20.w,
                          colorFilter: const ColorFilter.mode(AppColors.gray9F, BlendMode.srcIn),
                        ),
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 15.h),
                      BlocBuilder<InformationFormCubit, InformationFormState>(
                        buildWhen: (prev, curr) => prev.emailErrorMessage != curr.emailErrorMessage,
                        builder: (context, state) => AppLabelTextField(
                          label: tr("email"),
                          hintText: tr("emailHintText"),
                          defaultValue: _myAccountCubit.state.userProfile?.email ?? "",
                          prefixIcon: Assets.icons.icEmail.svg(
                            width: 20.w,
                            height: 20.w,
                            colorFilter: const ColorFilter.mode(AppColors.gray9F, BlendMode.srcIn),
                          ),
                          errorMessage: state.emailErrorMessage,
                          onChanged: (value) {
                            _cubit.onChangeEmail(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              BlocBuilder<InformationFormCubit, InformationFormState>(
                buildWhen: (prev, curr) => prev.isEnable != curr.isEnable,
                builder: (context, state) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: AppButton(
                    title: tr("update"),
                    color: AppColors.main,
                    fontSize: 14.sp,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w700,
                    isEnable: state.isEnable,
                    onPressed: () {
                      _cubit.updateProfile();
                    },
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? 25.h : 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
