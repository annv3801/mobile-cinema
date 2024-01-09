import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/domain/models/arguments/booking_room_arguments.dart';
import 'package:cinemax/domain/models/arguments/booking_seat_arguments.dart';
import 'package:cinemax/presentation/common_widgets/app_button.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_load_more.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/booking_room/booking_room_cubit.dart';
import 'package:cinemax/presentation/screens/booking_room/widget/cinema_detail_widget.dart';
import 'package:cinemax/presentation/screens/booking_room/widget/list_booking_date_widget.dart';
import 'package:cinemax/presentation/screens/booking_room/widget/scheduler_by_movie_error_widget.dart';
import 'package:cinemax/presentation/screens/booking_room/widget/scheduler_by_movie_loading_widget.dart';
import 'package:cinemax/presentation/screens/booking_room/widget/scheduler_by_movie_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingRoomScreen extends StatefulWidget {
  final BookingRoomArguments arguments;

  const BookingRoomScreen({super.key, required this.arguments});

  @override
  State<BookingRoomScreen> createState() => _BookingRoomScreenState();
}

class _BookingRoomScreenState extends State<BookingRoomScreen> {
  late BookingRoomCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<BookingRoomCubit>(context);
    _initData();
  }

  void _initData() {
    _cubit.getCinemaDetail(widget.arguments.cinemaId);
    _cubit.getSchedulerByMovie(cinemaId: widget.arguments.cinemaId, movieId: widget.arguments.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BookingRoomCubit, BookingRoomState>(
          listenWhen: (previous, current) => previous.bookingDate != current.bookingDate,
          listener: (_, state) {
            _cubit.getSchedulerByMovie(cinemaId: widget.arguments.cinemaId, movieId: widget.arguments.movieId);
          },
        ),
      ],
      child: AppPage(
        appBar: AppHeaderBar(title: tr("chooseDateAndTime")),
        body: BlocBuilder<BookingRoomCubit, BookingRoomState>(
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
                            CinemaDetailWidget(markers: state.markers, cinemaDetail: state.cinemaDetail!),
                            SizedBox(height: 10.h),
                            ListBookingDateWidget(cinemaId: widget.arguments.cinemaId),
                            SizedBox(height: 20.h),
                            BlocBuilder<BookingRoomCubit, BookingRoomState>(
                              buildWhen: (previous, current) => previous.getSchedulerDataStatus != current.getSchedulerDataStatus,
                              builder: (context, state) {
                                if (state.getSchedulerDataStatus == LoadStatus.failure) {
                                  return SchedulerByMovieErrorWidget(message: state.getSchedulerDataMessage ?? '');
                                }

                                if (state.getSchedulerDataStatus == LoadStatus.loading) {
                                  return const SchedulerByMovieLoadingWidget();
                                }

                                if (state.getSchedulerDataStatus == LoadStatus.success && state.schedulerData != null) {
                                  return SchedulerByMovieWidget(schedulerData: state.schedulerData!);
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
                  BlocBuilder<BookingRoomCubit, BookingRoomState>(
                    buildWhen: (previous, current) => previous.schedulerId != current.schedulerId,
                    builder: (context, state) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: AppButton(
                        isEnable: state.schedulerId != null,
                        title: tr("continue"),
                        color: AppColors.main,
                        fontSize: 14.sp,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w700,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RouteName.bookingSeat,
                            arguments: BookingSeatArguments(
                              schedulerId: state.schedulerId!,
                              movieId: widget.arguments.movieId,
                            ),
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
