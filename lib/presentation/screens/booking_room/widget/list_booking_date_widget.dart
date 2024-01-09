import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/extensions/date_time_extensions.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/screens/booking_room/booking_room_cubit.dart';
import 'package:cinemax/presentation/screens/cinema_detail/cinema_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListBookingDateWidget extends StatefulWidget {
  final int cinemaId;

  const ListBookingDateWidget({super.key, required this.cinemaId});

  @override
  State<ListBookingDateWidget> createState() => _ListBookingDateWidgetState();
}

class _ListBookingDateWidgetState extends State<ListBookingDateWidget> {
  late BookingRoomCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<BookingRoomCubit>(context);
    _cubit.getListBookingDate();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<BookingRoomCubit, BookingRoomState>(
          buildWhen: (previous, current) =>
          previous.listBookingDate != current.listBookingDate || previous.bookingDate != current.bookingDate,
          builder: (context, state) {
            if (state.listBookingDate.isNotEmpty) {
              return Row(
                children: List.generate(
                  state.listBookingDate.length,
                      (index) => _buildBookingDateItem(
                    state.listBookingDate[index],
                    isSelected: state.listBookingDate[index].isSameDay(state.bookingDate),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildBookingDateItem(DateTime date, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        _cubit.onChangeBookingDate(date);
      },
      child: Container(
        width: 55.r,
        height: 55.r,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          color: isSelected ? AppColors.main : AppColors.white,
          border: Border.all(color: isSelected ? AppColors.main : AppColors.greyD8, width: 1.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              date.day.toString(),
              color: isSelected ? AppColors.white : AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
            AppText(
              date.toWeekdayString,
              color: isSelected ? AppColors.white : AppColors.gray62,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
