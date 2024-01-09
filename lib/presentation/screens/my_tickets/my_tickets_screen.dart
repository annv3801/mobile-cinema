import 'package:cinemax/domain/models/dto/page_tab_model.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/screens/my_tickets/my_tickets_cubit.dart';
import 'package:cinemax/presentation/screens/my_tickets/widget/tab/list_cancelled_tickets_tab.dart';
import 'package:cinemax/presentation/screens/my_tickets/widget/tab/list_passed_tickets_tab.dart';
import 'package:cinemax/presentation/screens/my_tickets/widget/tab/list_upcoming_tickets_tab.dart';
import 'package:cinemax/presentation/screens/my_tickets/widget/tab/tab_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController _controller;
  late ValueNotifier<int> currentIndex;
  late List<PageTabModel> listTab;

  @override
  void initState() {
    super.initState();
    listTab = [
      PageTabModel(label: tr("upcoming"), child: const ListUpcomingTicketsTab()),
      PageTabModel(label: tr("passed"), child: const ListPassedTicketsTab()),
      PageTabModel(label: tr("cancelled"), child: const ListCancelledTicketsTab()),
    ];
    _controller = TabController(length: listTab.length, vsync: this, initialIndex: 0);
    currentIndex = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppPage(
      appBar: AppHeaderBar(title: tr("myTickets"), showClose: false),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
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
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: List.generate(
                listTab.length,
                (index) => BlocProvider(
                  create: (context) => MyTicketsCubit(),
                  child: listTab[index].child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
