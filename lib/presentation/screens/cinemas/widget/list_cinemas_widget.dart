import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/domain/models/arguments/booking_room_arguments.dart';
import 'package:cinemax/domain/models/arguments/cinema_detail_arguments.dart';
import 'package:cinemax/domain/models/response/cinemas/cinema_response.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_load_more.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/cinemas/widget/list_cinemas_error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCinemasWidget extends StatelessWidget {
  final int? movieId;
  final List<CinemaResponse> listCinemas;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final bool showLoadMoreIndicator;

  const ListCinemasWidget({
    super.key,
    this.movieId,
    required this.listCinemas,
    required this.onRefresh,
    required this.onLoadMore,
    required this.showLoadMoreIndicator,
  });

  @override
  Widget build(BuildContext context) {
    if (listCinemas.isNotEmpty) {
      return AppLoadMore(
        onRefresh: onRefresh,
        onLoadMore: onLoadMore,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: List.generate(
                  listCinemas.length,
                  (index) => _buildCinemaItem(
                    context,
                    item: listCinemas[index],
                    showDivider: index + 1 != listCinemas.length,
                  ),
                ),
              ),
              if (showLoadMoreIndicator)
                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: const AppLoadingIndicator(),
                ),
            ],
          ),
        ),
      );
    }

    return ListCinemasErrorWidget(message: tr("favoriteCinemaIsEmpty"));
  }

  Widget _buildCinemaItem(
    BuildContext context, {
    required CinemaResponse item,
    required bool showDivider,
  }) {
    return GestureDetector(
      onTap: () {
        if (movieId != null) {
          Navigator.of(context).pushNamed(
            RouteName.bookingRoom,
            arguments: BookingRoomArguments(movieId: movieId!, cinemaId: item.id),
          );
          return;
        }

        Navigator.of(context).pushNamed(
          RouteName.cinemaDetail,
          arguments: CinemaDetailArguments(cinemaId: item.id, cinemaName: item.name),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            width: 1.sw - 30.w,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                item.isFavorite
                    ? Assets.icons.icFavoriteFilled.svg(width: 20.r, height: 20.r)
                    : Assets.icons.icFavoriteOutlined.svg(width: 20.r, height: 20.r),
                SizedBox(width: 10.w),
                Expanded(
                  child: AppText(
                    item.name,
                    color: AppColors.black,
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 10.w),
                Assets.icons.icArrowRight.svg(width: 18.w, height: 18.w),
              ],
            ),
          ),
          if (showDivider) Container(width: 1.sw - 30.w, color: AppColors.greyEE, height: 1.w),
        ],
      ),
    );
  }
}
