import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/extensions/date_time_extensions.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_cinema_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_room_response.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/screens/booking_room/booking_room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SchedulerByMovieWidget extends StatefulWidget {
  final SchedulerDataResponse schedulerData;

  const SchedulerByMovieWidget({super.key, required this.schedulerData});

  @override
  State<SchedulerByMovieWidget> createState() => _SchedulerByMovieWidgetState();
}

class _SchedulerByMovieWidgetState extends State<SchedulerByMovieWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(15.w),
      color: AppColors.white,
      child: Column(
        children: List.generate(
          widget.schedulerData.rooms.length,
          (index) => _buildRoomItem(widget.schedulerData.rooms[index]),
        ),
      ),
    );
  }

  Widget _buildRoomItem(SchedulerRoomResponse data) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(data.room.name, fontSize: 15.sp, fontWeight: FontWeight.w700, color: AppColors.black),
            SizedBox(height: 10.h),
            BlocBuilder<BookingRoomCubit, BookingRoomState>(
              buildWhen: (previous, current) => previous.schedulerId != current.schedulerId,
              builder: (context, state) => Wrap(
                spacing: 15.w,
                runSpacing: 15.w,
                children: List.generate(data.times.length, (index) {
                  final isSelected = state.schedulerId == data.times[index].schedulerId;
                  final startTime = data.times[index].startTime?.toDateString;
                  final endTime = data.times[index].endTime?.toDateString;

                  return GestureDetector(
                    onTap: () {
                      context.read<BookingRoomCubit>().onChangeSchedulerId(data.times[index].schedulerId);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: isSelected ? AppColors.main : AppColors.greyD8),
                        borderRadius: BorderRadius.circular(8.w),
                        color: isSelected ? AppColors.main : AppColors.white,
                      ),
                      child: AppText(
                        "$startTime - $endTime",
                        fontSize: 14.sp,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        color: isSelected ? AppColors.white : AppColors.black,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
}
