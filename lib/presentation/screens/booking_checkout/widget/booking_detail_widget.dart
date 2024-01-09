import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/extensions/date_time_extensions.dart';
import 'package:cinemax/domain/models/response/booking/seat_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_detail_response.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailWidget extends StatelessWidget {
  final List<SeatResponse> listBookedSeats;
  final SchedulerDetailResponse schedulerDetail;

  const BookingDetailWidget({
    super.key,
    required this.schedulerDetail,
    required this.listBookedSeats,
  });

  @override
  Widget build(BuildContext context) {
    final seats = listBookedSeats.map((seat) => seat.roomSeat.name).join(", ");
    final date = DateFormat("dd/MM/yyyy").format(schedulerDetail.startTime ?? DateTime.now());
    final startTime = (schedulerDetail.startTime ?? DateTime.now()).toDateString;
    final endTime = (schedulerDetail.endTime ?? DateTime.now()).toDateString;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(tr("bookingDetails"), fontSize: 15.sp, fontWeight: FontWeight.w700, color: AppColors.black),
          SizedBox(height: 10.h),
          _buildRow(label: tr("cinema"), value: schedulerDetail.cinema.name),
          SizedBox(height: 5.h),
          _buildRow(label: tr("room"), value: schedulerDetail.room.name),
          SizedBox(height: 5.h),
          _buildRow(label: tr("seat"), value: seats),
          SizedBox(height: 5.h),
          _buildRow(label: tr("schedulerDate"), value: date),
          SizedBox(height: 5.h),
          _buildRow(label: tr("schedulerHours"), value: "$startTime - $endTime"),
        ],
      ),
    );
  }

  Widget _buildRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          label,
          fontSize: 14.sp,
          color: AppColors.gray62,
          fontWeight: FontWeight.w500,
        ),
        AppText(
          value,
          fontSize: 14.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
