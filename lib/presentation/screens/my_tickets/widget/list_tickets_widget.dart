import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/extensions/date_time_extensions.dart';
import 'package:cinemax/application/extensions/double_extensions.dart';
import 'package:cinemax/domain/models/arguments/booking_detail_arguments.dart';
import 'package:cinemax/domain/models/response/booking/booking_response.dart';
import 'package:cinemax/presentation/common_widgets/app_load_more.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_switch.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/widget/vertical_movie_thumbnail.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTicketsWidget extends StatefulWidget {
  final List<BookingResponse> listBookings;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final bool showLoadMoreIndicator;

  const ListTicketsWidget({
    super.key,
    required this.listBookings,
    this.onLoadMore,
    this.onRefresh,
    this.showLoadMoreIndicator = false,
  });

  @override
  State<ListTicketsWidget> createState() => _ListTicketsWidgetState();
}

class _ListTicketsWidgetState extends State<ListTicketsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 8.h),
      child: AppLoadMore(
        onRefresh: widget.onRefresh,
        onLoadMore: widget.onLoadMore,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: List.generate(
                  widget.listBookings.length,
                  (index) => _buildTicketItem(widget.listBookings[index]),
                ),
              ),
              if (widget.showLoadMoreIndicator)
                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: const AppLoadingIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketItem(BookingResponse item) {
    final date = DateFormat("dd/MM/yyyy").format(item.startTime ?? DateTime.now());
    final isRemind = ValueNotifier(false);
    final startTime = (item.startTime ?? DateTime.now()).toDateString;
    final endTime = (item.endTime ?? DateTime.now()).toDateString;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context)
            .pushNamed(
          RouteName.bookingDetail,
          arguments: BookingDetailArguments(bookingId: item.id),
        )
            .then((value) {
          if (value == true) {
            widget.onRefresh?.call();
          }
        });
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          border: Border.all(width: 1.r, color: AppColors.greyEE),
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  VerticalMovieThumbnail(width: 90.w, url: item.movieThumbnailUrl),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              item.movieName.toUpperCase(),
                              fontSize: 15.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.h),
                            AppText(
                              "$date • $startTime - $endTime",
                              fontSize: 12.sp,
                              color: AppColors.gray62,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 3.h),
                            AppText(
                              "${tr("cinema")}: ${item.cinemaName}",
                              fontSize: 12.sp,
                              color: AppColors.gray62,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            text: "${tr("totalPrice")}: ",
                            style: GoogleFonts.manrope(
                              fontSize: 12.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: item.total.toFormatMoney(),
                                style: GoogleFonts.manrope(
                                  fontSize: 13.sp,
                                  color: AppColors.main,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 1.r,
            //   color: AppColors.greyEE,
            //   margin: EdgeInsets.symmetric(vertical: 10.h),
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: AppText(
            //         tr("remind30MinutesEarlier"),
            //         fontSize: 11.sp,
            //         color: AppColors.gray62,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     SizedBox(width: 10.w),
            //     ValueListenableBuilder(
            //       valueListenable: isRemind,
            //       builder: (_, value, __) => AppSwitch(
            //         value: value,
            //         onToggle: () {
            //           isRemind.value = !value;
            //         },
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
