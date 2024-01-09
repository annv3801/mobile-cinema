import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/domain/models/arguments/cinemas_arguments.dart';
import 'package:cinemax/domain/models/dto/page_tab_model.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/screens/cinemas/cinemas_cubit.dart';
import 'package:cinemax/presentation/screens/cinemas/widget/tab/list_cinemas_tab.dart';
import 'package:cinemax/presentation/screens/cinemas/widget/tab/list_favorite_cinemas_tab.dart';
import 'package:cinemax/presentation/screens/cinemas/widget/tab/tab_item_widget.dart';
import 'package:cinemax/presentation/screens/list_favorites/cubit/favorite_cinemas_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemasScreen extends StatefulWidget {
  final CinemasArguments? arguments;

  const CinemasScreen({super.key, this.arguments});

  @override
  State<CinemasScreen> createState() => _CinemasScreenState();
}

class _CinemasScreenState extends State<CinemasScreen> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController _controller;
  late ValueNotifier<int> currentIndex;
  late List<PageTabModel> listTab;

  @override
  void initState() {
    super.initState();
    listTab = [
      PageTabModel(
        label: tr("all"),
        child: BlocProvider(
          create: (context) => CinemasCubit(),
          child: ListCinemasTab(movieId: widget.arguments?.movieId),
        ),
      ),
      PageTabModel(
        label: tr("favorite"),
        child: BlocProvider(
          create: (context) => FavoriteCinemasCubit(),
          child: ListFavoriteCinemasTab(movieId: widget.arguments?.movieId),
        ),
      ),
    ];
    _controller = TabController(length: listTab.length, vsync: this, initialIndex: 0);
    currentIndex = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppPage(
      appBar: AppHeaderBar(
        title: widget.arguments?.movieId != null ? tr("chooseCinema") : tr("cinemas"),
        showClose: widget.arguments?.movieId != null,
        // actions: [
        //   Assets.icons.icSearch.svg(width: 25.w, height: 25.w),
        // ],
      ),
      body: SafeArea(
        bottom: widget.arguments?.movieId != null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Assets.icons.icLocation.svg(width: 24.w, height: 24.w),
                          SizedBox(width: 5.w),
                          AppText(
                            tr("yourLocation"),
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                    AppText("Hà Nội", fontSize: 14.5.sp, fontWeight: FontWeight.w700, color: AppColors.black),
                  ],
                ),
              ),
              Container(width: 1.sw - 30.w, color: AppColors.greyEE, height: 1.w),
              if (widget.arguments?.movieId != null)
                Row(
                  children: List.generate(
                    listTab.length,
                    (index) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        currentIndex.value = index;
                        _controller.animateTo(index);
                      },
                      child: ValueListenableBuilder(
                        valueListenable: currentIndex,
                        builder: (_, value, __) => TabItemWidget(label: listTab[index].label, isSelected: value == index),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: List.generate(
                    listTab.length,
                    (index) => listTab[index].child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
