import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/double_extensions.dart';
import 'package:cinemax/domain/models/arguments/booking_checkout_arguments.dart';
import 'package:cinemax/domain/models/arguments/booking_seat_arguments.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_dialog.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/booking_seat/booking_seat_cubit.dart';
import 'package:cinemax/presentation/screens/booking_seat/widget/booking_seat_item_widget.dart';
import 'package:cinemax/presentation/screens/booking_seat/widget/cinema_screen_widget.dart';
import 'package:cinemax/presentation/screens/booking_seat/widget/list_tickets_type_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingSeatScreen extends StatefulWidget {
  final BookingSeatArguments arguments;

  const BookingSeatScreen({super.key, required this.arguments});

  @override
  State<BookingSeatScreen> createState() => _BookingSeatScreenState();
}

class _BookingSeatScreenState extends State<BookingSeatScreen> {
  late BookingSeatCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<BookingSeatCubit>(context);
    _cubit.getListBookingSeats(widget.arguments.schedulerId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BookingSeatCubit, BookingSeatState>(
          listenWhen: (previous, current) => previous.getListBookingSeatsStatus != current.getListBookingSeatsStatus,
          listener: (_, state) {
            if (state.getListBookingSeatsStatus == LoadStatus.failure) {
              AppDialog.showFailureDialog(
                context,
                title: tr("errorTitle"),
                content: state.getListBookingSeatsMessage ?? "",
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
                      Navigator.of(context).popUntil((route) => route.settings.name == RouteName.bookingRoom);
                    },
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<BookingSeatCubit, BookingSeatState>(
          listenWhen: (previous, current) => previous.listBookedSeats != current.listBookedSeats,
          listener: (_, state) {
            _cubit.calculateTotalPrice();
          },
        ),
      ],
      child: AppPage(
        backgroundColor: AppColors.greyF5,
        appBar: AppHeaderBar(title: tr("chooseSeat")),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<BookingSeatCubit, BookingSeatState>(
                buildWhen: (previous, current) => previous.getListBookingSeatsStatus != current.getListBookingSeatsStatus,
                builder: (_, state) {
                  if (state.getListBookingSeatsStatus == LoadStatus.loading) {
                    return Center(child: AppLoadingIndicator(sizeLoading: 40.r));
                  }

                  if (state.getListBookingSeatsStatus == LoadStatus.success && state.listBookingSeats.isNotEmpty) {
                    final maxColumn = state.listBookingSeats[0].length;
                    final isScroll = (maxColumn * 29.r) > 1.sw;

                    final width = isScroll ? (maxColumn * 29.r) : 1.sw;
                    final initialScrollOffset = ((width + 100.w) - 1.sw) / 2;

                    final scrollController = ScrollController(initialScrollOffset: initialScrollOffset);

                    return SingleChildScrollView(
                      controller: isScroll ? scrollController : null,
                      scrollDirection: Axis.horizontal,
                      physics: isScroll ? null : const ClampingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: isScroll ? 50.w : 0),
                      child: Container(
                        color: AppColors.greyF5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CinemaScreenWidget(),
                            SizedBox(height: 20.h),
                            Expanded(
                              child: Column(
                                children: [
                                  Column(
                                    children: List.generate(
                                      state.listBookingSeats.length,
                                      (index) => Row(
                                        children: List.generate(
                                          state.listBookingSeats[index].length,
                                          (idx) => BookingSeatItemWidget(item: state.listBookingSeats[index][idx]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 50.h),
                                  ListTicketsTypeWidget(listTicketsType: state.listTicketsType),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
            BlocBuilder<BookingSeatCubit, BookingSeatState>(
              buildWhen: (previous, current) =>
                  previous.listBookedSeats != current.listBookedSeats || previous.totalPrice != current.totalPrice,
              builder: (_, state) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 0),
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "${tr("totalPrice")}:",
                          style: GoogleFonts.manrope(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.black),
                          children: [
                            WidgetSpan(child: SizedBox(width: 5.w)),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: AppText(
                                state.totalPrice.toFormatMoney(),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.main,
                              ),
                            ),
                            WidgetSpan(child: SizedBox(width: 5.w)),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: state.listBookedSeats.isNotEmpty
                                  ? AppText(
                                      "(${tr("seats", namedArgs: {"count": state.listBookedSeats.length.toString()})})",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.gray62,
                                    )
                                  : const SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      AppButton(
                        title: tr("continue"),
                        color: AppColors.main,
                        fontSize: 14.sp,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w700,
                        isEnable: state.listBookedSeats.isNotEmpty,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RouteName.bookingCheckout,
                            arguments: BookingCheckoutArguments(
                              schedulerId: widget.arguments.schedulerId,
                              listBookedSeats: state.listBookedSeats,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? 25.h : 10.h),
          ],
        ),
      ),
    );
  }
}
