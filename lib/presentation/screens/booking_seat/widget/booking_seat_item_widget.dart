import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/booking_seat.dart';
import 'package:cinemax/domain/models/response/booking/seat_response.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/screens/booking_seat/booking_seat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingSeatItemWidget extends StatelessWidget {
  final SeatResponse? item;

  const BookingSeatItemWidget({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    if (item != null && item?.type == BookingSeatType.active) {
      final isTaken = item?.status == BookingSeatStatus.taken;

      return BlocBuilder<BookingSeatCubit, BookingSeatState>(
        buildWhen: (previous, current) => previous.listBookedSeats != current.listBookedSeats,
        builder: (context, state) {
          final isSelected = state.listBookedSeats.any((element) => element.id == item!.id);

          return GestureDetector(
            onTap: () {
              if (isTaken) return;

              context.read<BookingSeatCubit>().onSelectBookingSeats(item!);
            },
            child: Container(
              width: 25.r,
              height: 25.r,
              margin: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  width: 2.r,
                  color: isSelected ? AppColors.main : (isTaken ? AppColors.gray9F : item!.ticket.fromHexColor),
                ),
                color: isSelected ? AppColors.main : (isTaken ? AppColors.gray9F : AppColors.white),
              ),
              child: Center(
                child: AppText(
                  item!.roomSeat.name,
                  fontSize: 10.sp,
                  color: isSelected ? AppColors.white : (isTaken ? AppColors.white : item!.ticket.fromHexColor),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
      );
    }

    return Container(
      width: 25.r,
      height: 25.r,
      margin: EdgeInsets.all(2.r),
      color: AppColors.greyF5,
    );
  }
}
