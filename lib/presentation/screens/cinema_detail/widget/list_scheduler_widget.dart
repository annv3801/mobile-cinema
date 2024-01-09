import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/extensions/date_time_extensions.dart';
import 'package:cinemax/domain/models/response/movies/movie_detail_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_cinema_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_room_response.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/widget/vertical_movie_thumbnail.dart';
import 'package:cinemax/presentation/screens/cinema_detail/cinema_detail_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListSchedulerWidget extends StatefulWidget {
  final List<SchedulerCinemaResponse> listSchedulers;

  const ListSchedulerWidget({super.key, required this.listSchedulers});

  @override
  State<ListSchedulerWidget> createState() => _ListSchedulerWidgetState();
}

class _ListSchedulerWidgetState extends State<ListSchedulerWidget> {
  late CinemaDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<CinemaDetailCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.listSchedulers.length,
        (index) => _buildSchedulerItem(widget.listSchedulers[index].data.first),
      ),
    );
  }

  Widget _buildSchedulerItem(SchedulerDataResponse scheduler) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(15.w),
      color: AppColors.white,
      child: Column(
        children: [
          _buildMovieInformation(scheduler.movie),
          SizedBox(height: 10.h),
          Column(
            children: List.generate(
              scheduler.rooms.length,
              (index) => _buildRoomItem(scheduler.rooms[index], scheduler.movie.id),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieInformation(MovieDetailResponse movie) {
    final width = (1.sw - 30.w) * 0.4;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalMovieThumbnail(width: width, url: movie.thumbnailUrl),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                movie.name.toUpperCase(),
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              SizedBox(height: 15.h),
              _buildRow(label: tr("director"), value: movie.director),
              SizedBox(height: 8.h),
              _buildRow(label: tr("genre"), value: movie.genre),
              SizedBox(height: 8.h),
              _buildRow(label: tr("premiere"), value: movie.premiere),
              SizedBox(height: 8.h),
              _buildRow(label: tr("duration"), value: "${movie.duration} ${tr("minutes").toLowerCase()}"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow({required String label, required String value}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70.w,
            child: AppText(label, fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.gray62),
          ),
          AppText(" : ", fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.gray62),
          Expanded(child: AppText(value, fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.gray62)),
        ],
      );

  Widget _buildRoomItem(SchedulerRoomResponse data, int movieId) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(data.room.name, fontSize: 15.sp, fontWeight: FontWeight.w700, color: AppColors.black),
            SizedBox(height: 10.h),
            BlocBuilder<CinemaDetailCubit, CinemaDetailState>(
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
                      _cubit.onChangeScheduler(
                        movieId: movieId,
                        schedulerId: data.times[index].schedulerId,
                      );
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
