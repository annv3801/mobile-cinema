import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/domain/models/arguments/home_tab_arguments.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_check_box.dart';
import 'package:cinemax/presentation/common_widgets/app_dialog.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_label_text_field.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/auth/login/login_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<LoginCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) => previous.phoneNumber != current.phoneNumber || previous.password != current.password,
          listener: (context, state) {
            _cubit.checkEnableButton();
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) => previous.loginStatus != current.loginStatus,
          listener: (_, state) {
            if (state.loginStatus == LoadStatus.failure) {
              AppDialog.showFailureDialog(
                context,
                title: tr("signInFailure"),
                content: state.loginMessage,
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

            if (state.loginStatus == LoadStatus.success) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteName.homeTab,
                (route) => false,
                arguments: const HomeTabArguments(index: 0),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.loginStatus != current.loginStatus,
        builder: (context, state) => AppPage(
          isLoading: state.loginStatus == LoadStatus.loading,
          appBar: const AppHeaderBar(title: "", showClose: false),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 1.sw - 40.w,
                            child: Text.rich(TextSpan(
                              text: tr("welcomeBack"),
                              style: GoogleFonts.manrope(color: AppColors.black, fontSize: 23.w, fontWeight: FontWeight.w700),
                              children: [
                                WidgetSpan(child: SizedBox(width: 10.w)),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Assets.images.imgWave.image(width: 25.w, fit: BoxFit.fitWidth),
                                ),
                              ],
                            )),
                          ),
                          SizedBox(height: 50.h),
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
                            builder: (context, state) => AppLabelTextField(
                              label: tr("phoneNumber"),
                              hintText: tr("phoneNumber"),
                              prefixIcon: Assets.icons.icPhoneOutlined.svg(
                                width: 20.w,
                                height: 20.w,
                                colorFilter: ColorFilter.mode(
                                  state.phoneNumber.isNotEmpty ? AppColors.black : AppColors.gray9F,
                                  BlendMode.srcIn,
                                ),
                              ),
                              onChanged: (value) {
                                _cubit.onChangePhoneNumber(value);
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          BlocBuilder<LoginCubit, LoginState>(
                            bloc: _cubit,
                            buildWhen: (previous, current) =>
                                previous.password != current.password || previous.showPassword != current.showPassword,
                            builder: (context, state) => AppLabelTextField(
                              label: tr("password"),
                              hintText: "••••••••",
                              prefixIcon: Assets.icons.icPassword.svg(
                                width: 24.w,
                                height: 24.w,
                                colorFilter: ColorFilter.mode(
                                  state.password.isNotEmpty ? AppColors.black : AppColors.gray9F,
                                  BlendMode.srcIn,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _cubit.onChangeShowPassword(!state.showPassword);
                                },
                                child: state.showPassword
                                    ? Assets.icons.icShowPassword.svg(
                                        width: 24.w,
                                        height: 24.w,
                                        colorFilter: ColorFilter.mode(
                                          state.password.isNotEmpty ? AppColors.black : AppColors.gray9F,
                                          BlendMode.srcIn,
                                        ),
                                      )
                                    : Assets.icons.icHidePassword.svg(
                                        width: 24.w,
                                        height: 24.w,
                                        colorFilter: ColorFilter.mode(
                                          state.password.isNotEmpty ? AppColors.black : AppColors.gray9F,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                              ),
                              obscureText: !state.showPassword,
                              onChanged: (value) {
                                _cubit.onChangePassword(value);
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  AppCheckBox(
                                    isChecked: true,
                                    activeColor: AppColors.main,
                                    checkColor: AppColors.white,
                                    borderColor: AppColors.main,
                                    size: 20.w,
                                    borderRadius: 4.w,
                                  ),
                                  SizedBox(width: 5.w),
                                  AppText(tr("rememberMe"), fontSize: 13.sp, color: AppColors.black, fontWeight: FontWeight.w700),
                                ],
                              ),
                              AppText(tr("forgotPassword"), fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.w700),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          const Divider(color: AppColors.greyF5),
                          SizedBox(height: 20.h),
                          Text.rich(
                            TextSpan(
                              text: tr("dontHaveAnAccount"),
                              style: GoogleFonts.manrope(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.black),
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).pushNamed(RouteName.register);
                                    },
                                    child: AppText(
                                      " ${tr("signUp")}",
                                      fontSize: 13.5.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.main,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) => previous.isEnable != current.isEnable,
                    builder: (context, state) => AppButton(
                      title: tr("signIn"),
                      color: AppColors.main,
                      fontSize: 14.sp,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w600,
                      isEnable: state.isEnable,
                      onPressed: () {
                        _cubit.login();
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
