import 'package:cinemax/di.dart';
import 'package:cinemax/presentation/common_widgets/app_load_more.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/screens/home/home_cubit.dart';
import 'package:cinemax/presentation/screens/home/widget/group/list_groups_widget.dart';
import 'package:cinemax/presentation/screens/home/widget/home_carousel_slider_widget.dart';
import 'package:cinemax/presentation/screens/home/widget/home_header_widget.dart';
import 'package:cinemax/presentation/screens/home/widget/list_news_widget.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  final _homeCubit = getIt<HomeCubit>();
  final _accountCubit = getIt<MyAccountCubit>();

  @override
  void initState() {
    super.initState();
    _homeCubit.getListGroups();
    _homeCubit.getCarouselSlider();
    _homeCubit.getListNews();
  }

  void initData() {
    _accountCubit.getUserProfile(forceRefresh: true);
    _homeCubit.getCarouselSlider();
    _homeCubit.getListGroups();
    _homeCubit.getListNews();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppPage(
      body: SafeArea(
        bottom: false,
        child: AppLoadMore(
          onRefresh: initData,
          onLoadMore: () {
            _homeCubit.getMoreNews();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HomeHeaderWidget(),
                SizedBox(height: 15.h),
                const HomeCarouselSliderWidget(),
                SizedBox(height: 15.h),
                const ListGroupsWidget(),
                const ListNewsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
