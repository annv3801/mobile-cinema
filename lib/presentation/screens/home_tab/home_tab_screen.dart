import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/domain/models/arguments/home_tab_arguments.dart';
import 'package:cinemax/domain/models/dto/home_page_model.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:cinemax/presentation/screens/cinemas/cinemas_screen.dart';
import 'package:cinemax/presentation/screens/home/home_screen.dart';
import 'package:cinemax/presentation/screens/home_tab/widget/bottom_bar_widget.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_screen.dart';
import 'package:cinemax/presentation/screens/my_tickets/my_tickets_screen.dart';
import 'package:cinemax/presentation/screens/notification/notification_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeTabScreen extends StatefulWidget {
  final HomeTabArguments arguments;

  const HomeTabScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  late PageController controller;
  late ValueNotifier<int> currentIndex;

  final listPages = [
    HomePageModel(
      name: tr("home"),
      selectedIconUrl: Assets.icons.icHomeFilled.path,
      unselectedIconUrl: Assets.icons.icHomeOutlined.path,
      child: const HomeScreen(),
    ),
    HomePageModel(
      name: tr("cinemas"),
      selectedIconUrl: Assets.icons.icCinemasFilled.path,
      unselectedIconUrl: Assets.icons.icCinemasOutlined.path,
      child: const CinemasScreen(),
    ),
    HomePageModel(
      name: tr("myTickets"),
      selectedIconUrl: Assets.icons.icTicketFilled.path,
      unselectedIconUrl: Assets.icons.icTicketOutlined.path,
      child: const MyTicketsScreen(),
    ),
    HomePageModel(
      name: tr("notification"),
      selectedIconUrl: Assets.icons.icNotificationFilled.path,
      unselectedIconUrl: Assets.icons.icNotificationOutlined.path,
      child: const NotificationScreen(),
    ),
    HomePageModel(
      name: tr("myAccount"),
      selectedIconUrl: Assets.icons.icUserFilled.path,
      unselectedIconUrl: Assets.icons.icUserOutlined.path,
      child: const MyAccountScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = ValueNotifier<int>(widget.arguments.index);
    controller = PageController(initialPage: widget.arguments.index);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: listPages.map((item) => SafeArea(bottom: false, child: item.child)).toList(),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: currentIndex,
            builder: (_, value, __) => BottomBarWidget(
              currentIndex: value,
              listPage: listPages,
              onTap: (index) {
                currentIndex.value = index;
                controller.jumpToPage(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
