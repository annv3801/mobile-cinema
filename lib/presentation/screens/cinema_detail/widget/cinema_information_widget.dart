import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/constants/app_constants.dart';
import 'package:cinemax/domain/models/response/cinemas/cinema_detail_response.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/common_widgets/total_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CinemaInformationWidget extends StatelessWidget {
  final List<Marker> markers;
  final CinemaDetailResponse cinemaDetail;

  const CinemaInformationWidget({
    super.key,
    required this.markers,
    required this.cinemaDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 1.sw - 30.w,
            height: 200.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.w),
              child: GoogleMap(
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(cinemaDetail.latitude, cinemaDetail.longitude),
                  zoom: AppConstants.mapZoom,
                ),
                markers: markers.toSet(),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              text: "",
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: TotalRatingWidget(
                    size: 15.w,
                    totalRating: cinemaDetail.totalRating,
                  ),
                ),
                TextSpan(text: " (${cinemaDetail.totalRating})"),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.icons.icLocation.svg(width: 18.w, height: 18.w),
              SizedBox(width: 8.w),
              Expanded(
                child: AppText(
                  cinemaDetail.location,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Assets.icons.icPhoneOutlined.svg(width: 18.w, height: 18.w),
              SizedBox(width: 8.w),
              Expanded(
                child: AppText(
                  cinemaDetail.phoneNumber,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
