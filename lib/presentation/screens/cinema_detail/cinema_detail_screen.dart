import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/domain/models/arguments/booking_seat_arguments.dart';
import 'package:cinemax/domain/models/arguments/cinema_detail_arguments.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_dialog.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_load_more.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/cinema_detail/cinema_detail_cubit.dart';
import 'package:cinemax/presentation/screens/cinema_detail/widget/cinema_information_widget.dart';
import 'package:cinemax/presentation/screens/cinema_detail/widget/list_booking_date_widget.dart';
import 'package:cinemax/presentation/screens/cinema_detail/widget/list_scheduler_error_widget.dart';
import 'package:cinemax/presentation/screens/cinema_detail/widget/list_scheduler_loading_widget.dart';
import 'package:cinemax/presentation/screens/cinema_detail/widget/list_scheduler_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaDetailScreen extends StatefulWidget {
  final CinemaDetailArguments arguments;

  const CinemaDetailScreen({super.key, required this.arguments});

  @override
  State<CinemaDetailScreen> createState() => _CinemaDetailScreenState();
}

class _CinemaDetailScreenState extends State<CinemaDetailScreen> {
  late CinemaDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<CinemaDetailCubit>(context);
    _initData();
  }

  void _initData() {
    _cubit.getCinemaDetail(widget.arguments.cinemaId);
    _cubit.getListSchedulers(widget.arguments.cinemaId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CinemaDetailCubit, CinemaDetailState>(
          listenWhen: (previous, current) => previous.favoriteCinemaStatus != current.favoriteCinemaStatus,
          listener: (_, state) {
            if (state.favoriteCinemaStatus == LoadStatus.failure && state.favoriteCinemaMessage?.isNotEmpty == true) {
              AppDialog.showFailureDialog(
                context,
                title: tr("errorTitle"),
                content: state.favoriteCinemaMessage,
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
                      Navigator.of(context).popUntil((route) => route.settings.name == RouteName.cinemaDetail);
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: AppPage(
        appBar: AppHeaderBar(
          title: widget.arguments.cinemaName,
          actions: [
            BlocBuilder<CinemaDetailCubit, CinemaDetailState>(
              buildWhen: (previous, current) =>
                  previous.favoriteCinemaStatus != current.favoriteCinemaStatus ||
                  previous.getCinemaDetailStatus != current.getCinemaDetailStatus ||
                  previous.isFavorite != current.isFavorite,
              builder: (context, state) {
                if (state.getCinemaDetailStatus == LoadStatus.loading) {
                  return const SizedBox();
                }

                if (state.favoriteCinemaStatus == LoadStatus.loading) {
                  return AppLoadingIndicator(sizeLoading: 20.r);
                }

                return GestureDetector(
                  onTap: () {
                    _cubit.favoriteCinema(widget.arguments.cinemaId);
                  },
                  child: state.isFavorite
                      ? Assets.icons.icFavoriteFilled.svg(width: 20.r, height: 20.r)
                      : Assets.icons.icFavoriteOutlined.svg(width: 20.r, height: 20.r),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<CinemaDetailCubit, CinemaDetailState>(
          buildWhen: (previous, current) => previous.getCinemaDetailStatus != current.getCinemaDetailStatus,
          builder: (context, state) {
            if (state.getCinemaDetailStatus == LoadStatus.loading) {
              return Center(child: AppLoadingIndicator(sizeLoading: 40.r));
            }

            if (state.getCinemaDetailStatus == LoadStatus.failure) {
              return Center(
                child: AppText(
                  state.getCinemaDetailMessage ?? "",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state.getCinemaDetailStatus == LoadStatus.success) {
              return Column(
                children: [
                  Expanded(
                    child: AppLoadMore(
                      onRefresh: _initData,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CinemaInformationWidget(markers: state.markers, cinemaDetail: state.cinemaDetail!),
                            SizedBox(height: 10.h),
                            ListBookingDateWidget(cinemaId: widget.arguments.cinemaId),
                            SizedBox(height: 10.h),
                            BlocBuilder<CinemaDetailCubit, CinemaDetailState>(
                              buildWhen: (previous, current) => previous.getListSchedulersStatus != current.getListSchedulersStatus,
                              builder: (context, state) {
                                if (state.getListSchedulersStatus == LoadStatus.failure) {
                                  return ListSchedulerErrorWidget(message: state.getListSchedulersMessage ?? '');
                                }

                                if (state.getListSchedulersStatus == LoadStatus.loading) {
                                  return const ListSchedulerLoadingWidget();
                                }

                                if (state.getListSchedulersStatus == LoadStatus.success) {
                                  if (state.listCinemaSchedulers.isNotEmpty) {
                                    return ListSchedulerWidget(listSchedulers: state.listCinemaSchedulers);
                                  }

                                  return ListSchedulerErrorWidget(message: tr("listSchedulersIsEmpty"));
                                }

                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  BlocBuilder<CinemaDetailCubit, CinemaDetailState>(
                    buildWhen: (previous, current) => previous.schedulerId != current.schedulerId || previous.movieId != current.movieId,
                    builder: (context, state) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: AppButton(
                        isEnable: state.schedulerId != null || state.movieId != null,
                        title: tr("bookNow"),
                        color: AppColors.main,
                        fontSize: 14.sp,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w700,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RouteName.bookingSeat,
                            arguments: BookingSeatArguments(schedulerId: state.schedulerId!, movieId: state.movieId!),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? 25.h : 10.h),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
