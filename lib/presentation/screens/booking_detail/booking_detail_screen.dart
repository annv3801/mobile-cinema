import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/date_time_extensions.dart';
import 'package:cinemax/application/extensions/double_extensions.dart';
import 'package:cinemax/domain/models/arguments/booking_detail_arguments.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_dialog.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/screens/booking_detail/booking_detail_cubit.dart';
import 'package:cinemax/presentation/screens/booking_detail/widget/ticket_clipper_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetailScreen extends StatefulWidget {
  final BookingDetailArguments arguments;

  const BookingDetailScreen({super.key, required this.arguments});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  late BookingDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<BookingDetailCubit>(context);
    _cubit.getBookingDetail(widget.arguments.bookingId);
  }

  void showCancelConfirmationDialog() {
    AppDialog.showCustomDialog(
      context,
      title: tr("cancelBookingTitle"),
      action: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            Expanded(
              child: AppButton(
                title: tr("cancelBooking"),
                fontSize: 14.sp,
                color: AppColors.pink,
                textColor: AppColors.main,
                fontWeight: FontWeight.w600,
                height: 40.h,
                onPressed: () {
                  Navigator.of(context).pop();
                  _cubit.cancelBooking(widget.arguments.bookingId);
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
    return MultiBlocListener(
      listeners: [
        BlocListener<BookingDetailCubit, BookingDetailState>(
          listenWhen: (prev, curr) => prev.cancelBookingStatus != curr.cancelBookingStatus,
          listener: (_, state) {
            if (state.cancelBookingStatus == LoadStatus.failure) {
              AppDialog.showFailureDialog(
                context,
                title: tr("errorTitle"),
                content: state.cancelBookingMessage,
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

            if (state.cancelBookingStatus == LoadStatus.success) {
              Navigator.of(context).pop(true);
            }
          },
        ),
      ],
      child: BlocBuilder<BookingDetailCubit, BookingDetailState>(
        buildWhen: (prev, curr) => prev.cancelBookingStatus != curr.cancelBookingStatus,
        builder: (context, state) {
          return AppPage(
            isLoading: state.cancelBookingStatus == LoadStatus.loading,
            backgroundColor: AppColors.main,
            appBar: AppHeaderBar(
              title: tr("bookingDetail"),
              backgroundColor: AppColors.main,
              color: AppColors.white,
              actions: [
                BlocBuilder<BookingDetailCubit, BookingDetailState>(
                  buildWhen: (prev, curr) => prev.bookingDetail != curr.bookingDetail,
                  builder: (context, state) {
                    if (state.bookingDetail?.isComingSoon == true) {
                      return GestureDetector(
                        onTap: showCancelConfirmationDialog,
                        child: Assets.icons.icCancel.svg(
                          width: 20.r,
                          height: 20.r,
                          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                )
              ],
            ),
            body: BlocBuilder<BookingDetailCubit, BookingDetailState>(
              buildWhen: (previous, current) => previous.getBookingDetailStatus != current.getBookingDetailStatus,
              builder: (context, state) {
                if (state.getBookingDetailStatus == LoadStatus.loading) {
                  return Center(child: AppLoadingIndicator(sizeLoading: 40.r, color: AppColors.white));
                }

                if (state.getBookingDetailStatus == LoadStatus.failure) {
                  return Center(
                    child: AppText(
                      state.getBookingDetailMessage ?? "",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state.getBookingDetailStatus == LoadStatus.success) {
                  final date = DateFormat("dd/MM/yyyy").format(state.bookingDetail!.startTime ?? DateTime.now());
                  final startTime = (state.bookingDetail!.startTime ?? DateTime.now()).toDateString;
                  final endTime = (state.bookingDetail!.endTime ?? DateTime.now()).toDateString;

                  return Container(
                    width: 1.sw,
                    height: 1.sh,
                    padding: EdgeInsets.fromLTRB(
                      16.w,
                      10.h,
                      16.w,
                      MediaQuery.of(context).padding.bottom > 0 ? 25.h : 10.h,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 8),
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 37,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: ClipPath(
                      clipper: TicketClipper(
                        borderRadius: 10.r,
                        clipRadius: 12.5.r,
                        smallClipRadius: 2.r,
                        numberOfSmallClips: 25,
                      ),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(height: 45.h),
                            QrImageView(
                              data: state.bookingDetail!.id.toString(),
                              version: QrVersions.auto,
                              size: 150.h,
                            ),
                            AppText(
                              tr("scanQrCodeToEnterTheTheatre"),
                              fontSize: 13.sp,
                              color: AppColors.gray62,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 80.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Column(
                                children: [
                                  AppText(
                                    state.bookingDetail!.movie.name.toUpperCase(),
                                    fontSize: 16.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8.h),
                                  AppText(
                                    "${tr("duration")}: ${state.bookingDetail!.movie.duration} ${tr("minutes").toLowerCase()}",
                                    fontSize: 13.sp,
                                    color: AppColors.gray62,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            const Divider(color: AppColors.greyF5),
                            SizedBox(height: 8.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Column(
                                children: [
                                  AppText(
                                    state.bookingDetail!.cinema.name.toUpperCase(),
                                    fontSize: 16.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8.h),
                                  AppText(
                                    "$date • $startTime - $endTime",
                                    fontSize: 13.sp,
                                    color: AppColors.gray62,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8.h),
                                  AppText(
                                    "${tr("bookingCode")}: ${state.bookingDetail!.id}",
                                    fontSize: 13.sp,
                                    color: AppColors.gray62,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(tr("seat"), fontSize: 13.sp, color: AppColors.gray62, fontWeight: FontWeight.w400),
                                    SizedBox(height: 4.h),
                                    AppText(
                                      state.bookingDetail!.seats.map((seat) => seat.roomSeat.name).join(", "),
                                      fontSize: 14.sp,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    AppText(tr("cinemaRoom"), fontSize: 13.sp, color: AppColors.gray62, fontWeight: FontWeight.w400),
                                    SizedBox(height: 4.h),
                                    AppText(
                                      state.bookingDetail!.cinemaRoom,
                                      fontSize: 14.sp,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            const Divider(color: AppColors.greyF5),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  tr("totalPrice"),
                                  fontSize: 14.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                AppText(
                                  state.bookingDetail!.total.toFormatMoney(),
                                  fontSize: 14.sp,
                                  color: AppColors.main,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AppText(
                                      tr("viewMoreInWebsite"),
                                      fontSize: 12.sp,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(height: 4.h),
                                    GestureDetector(
                                      onTap: () {
                                        launchUrl(Uri.parse("https://appstoreconnect.apple.com/apps"));
                                      },
                                      child: AppText(
                                        "https://appstoreconnect.apple.com/apps",
                                        fontSize: 12.sp,
                                        color: AppColors.main,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}
