import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/domain/models/response/booking/seat_response.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTicketsTypeWidget extends StatelessWidget {
  final List<TicketResponse> listTicketsType;

  const ListTicketsTypeWidget({super.key, required this.listTicketsType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 15.w,
        runSpacing: 10.h,
        children: [
          ...List.generate(
            listTicketsType.length,
            (index) => _buildTicketItem(listTicketsType[index]),
          ),
          _buildCustomTicketItem(title: tr("selected"), color: AppColors.main),
          _buildCustomTicketItem(title: tr("taken"), color: AppColors.gray9F),
        ],
      ),
    );
  }

  Widget _buildCustomTicketItem({required String title, required Color color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18.r,
          height: 18.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
            border: Border.all(width: 2.r, color: color),
            color: color,
          ),
        ),
        SizedBox(width: 5.w),
        AppText(
          title,
          fontSize: 12.sp,
          color: AppColors.gray62,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildTicketItem(TicketResponse item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18.r,
          height: 18.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
            border: Border.all(width: 2.r, color: item.fromHexColor),
            color: item.fromHexColor,
          ),
        ),
        SizedBox(width: 5.w),
        AppText(
          item.title,
          fontSize: 12.sp,
          color: AppColors.gray62,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
