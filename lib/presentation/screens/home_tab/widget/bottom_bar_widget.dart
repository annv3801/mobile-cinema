import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/domain/models/dto/home_page_model.dart';
import 'package:cinemax/presentation/screens/home_tab/widget/bottom_bar_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

class BottomBarWidget extends StatefulWidget {
  final int currentIndex;
  final List<HomePageModel> listPage;
  final Function(int index) onTap;

  const BottomBarWidget({
    Key? key,
    required this.currentIndex,
    required this.listPage,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 25.h : 10.h),
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 15.0, offset: Offset(0.0, 0.05))],
        color: AppColors.white,
      ),
      child: Row(
        children: widget.listPage.mapIndexed((index, item) {
          return GestureDetector(
            onTap: () {
              widget.onTap.call(index);
            },
            behavior: HitTestBehavior.opaque,
            child: BottomBarItemWidget(
              item: item,
              isSelected: widget.currentIndex == index,
            ),
          );
        }).toList(),
      ),
    );
  }
}
