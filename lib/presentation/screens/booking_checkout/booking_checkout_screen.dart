import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/enums/payment_method.dart';
import 'package:cinemax/application/extensions/double_extensions.dart';
import 'package:cinemax/domain/models/arguments/booking_checkout_arguments.dart';
import 'package:cinemax/domain/models/arguments/home_tab_arguments.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_dialog.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/booking_checkout/booking_checkout_cubit.dart';
import 'package:cinemax/presentation/screens/booking_checkout/widget/booking_detail_widget.dart';
import 'package:cinemax/presentation/screens/booking_checkout/widget/movie_information_widget.dart';
import 'package:cinemax/presentation/screens/booking_checkout/widget/payment_method_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingCheckoutScreen extends StatefulWidget {
  final BookingCheckoutArguments arguments;

  const BookingCheckoutScreen({super.key, required this.arguments});

  @override
  State<BookingCheckoutScreen> createState() => _BookingCheckoutScreenState();
}

class _BookingCheckoutScreenState extends State<BookingCheckoutScreen> {
  late BookingCheckoutCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<BookingCheckoutCubit>(context);
    _cubit.getSchedulerDetail(widget.arguments.schedulerId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BookingCheckoutCubit, BookingCheckoutState>(
          listenWhen: (previous, current) => previous.createBookingStatus != current.createBookingStatus,
          listener: (_, state) {
            if (state.createBookingStatus == LoadStatus.failure) {
              AppDialog.showFailureDialog(
                context,
                title: tr("bookingTicketError"),
                content: state.createBookingMessage,
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

            if (state.createBookingStatus == LoadStatus.success) {
              AppDialog.showSuccessDialog(
                context,
                title: tr("bookingTicketSuccess"),
                content: tr("bookingTicketSuccessContent"),
                action: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Column(
                    children: [
                      AppButton(
                        title: tr("viewMyTicket"),
                        fontSize: 14.sp,
                        color: AppColors.main,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w600,
                        height: 40.h,
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteName.homeTab,
                            (route) => false,
                            arguments: const HomeTabArguments(index: 2),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      AppButton(
                        title: tr("backToHome"),
                        fontSize: 14.sp,
                        color: AppColors.pink,
                        textColor: AppColors.main,
                        fontWeight: FontWeight.w600,
                        height: 40.h,
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteName.homeTab,
                            (route) => false,
                            arguments: const HomeTabArguments(index: 0),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<BookingCheckoutCubit, BookingCheckoutState>(
          listenWhen: (previous, current) => previous.createVnPayPaymentStatus != current.createVnPayPaymentStatus,
          listener: (_, state) async {
            if (state.createVnPayPaymentStatus == LoadStatus.failure) {
              AppDialog.showFailureDialog(
                context,
                title: tr("paymentError"),
                content: state.createVnPayPaymentMessage,
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

            if (state.createVnPayPaymentStatus == LoadStatus.success) {
              final isSuccess = await Navigator.of(context).pushNamed(
                RouteName.vnPayPayment,
                arguments: state.vnPayPaymentUrl!,
              ) as bool?;

              if (isSuccess == true) {
                _cubit.createBooking(widget.arguments.listBookedSeats);
              }
            }
          },
        )
      ],
      child: BlocBuilder<BookingCheckoutCubit, BookingCheckoutState>(
        buildWhen: (previous, current) =>
            previous.createBookingStatus != current.createBookingStatus ||
            previous.createVnPayPaymentStatus != current.createVnPayPaymentStatus,
        builder: (context, state) => AppPage(
          isLoading: state.createBookingStatus == LoadStatus.loading || state.createVnPayPaymentStatus == LoadStatus.loading,
          appBar: AppHeaderBar(title: tr("payment")),
          body: Column(
            children: [
              Expanded(
                child: BlocBuilder<BookingCheckoutCubit, BookingCheckoutState>(
                  buildWhen: (previous, current) => previous.getSchedulerStatus != current.getSchedulerStatus,
                  builder: (context, state) {
                    if (state.getSchedulerStatus == LoadStatus.loading) {
                      return Center(child: AppLoadingIndicator(sizeLoading: 40.r));
                    }

                    if (state.getSchedulerStatus == LoadStatus.success) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        child: Column(
                          children: [
                            MovieInformationWidget(movieInfo: state.schedulerDetail!.movie),
                            SizedBox(height: 25.h),
                            BookingDetailWidget(
                              listBookedSeats: widget.arguments.listBookedSeats,
                              schedulerDetail: state.schedulerDetail!,
                            ),
                            SizedBox(height: 25.h),
                            const PaymentMethodWidget(),
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
              SizedBox(height: 15.h),
              BlocBuilder<BookingCheckoutCubit, BookingCheckoutState>(
                buildWhen: (previous, current) =>
                    previous.getSchedulerStatus != current.getSchedulerStatus || previous.paymentMethod != current.paymentMethod,
                builder: (context, state) {
                  if (state.getSchedulerStatus == LoadStatus.loading) {
                    return const SizedBox();
                  }

                  double totalPrice = 0;
                  for (var i = 0; i < widget.arguments.listBookedSeats.length; i++) {
                    totalPrice = totalPrice + widget.arguments.listBookedSeats[i].ticket.price;
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: AppButton(
                      isEnable: state.paymentMethod != null,
                      title: "${tr("payNow")} • ${totalPrice.toFormatMoney()}",
                      color: AppColors.main,
                      fontSize: 14.sp,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w700,
                      onPressed: () {
                        if (state.paymentMethod == PaymentMethod.vnPay) {
                          _cubit.createVnPayPayment(totalPrice);
                          return;
                        }

                        _cubit.createBooking(widget.arguments.listBookedSeats);
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? 25.h : 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
