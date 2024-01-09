import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_load_more.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/screens/notification/notification_cubit.dart';
import 'package:cinemax/presentation/screens/notification/widget/notification_error_widget.dart';
import 'package:cinemax/presentation/screens/notification/widget/notification_item_widget.dart';
import 'package:cinemax/presentation/screens/notification/widget/notification_loading_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with AutomaticKeepAliveClientMixin {
  final _notificationCubit = getIt<NotificationCubit>();

  @override
  void initState() {
    super.initState();
    _notificationCubit.getListNotifications();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppPage(
      appBar: AppHeaderBar(title: tr("yourNotification"), showClose: false),
      body: SafeArea(
        child: SizedBox(
          width: 1.sw,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<NotificationCubit, NotificationState>(
                  bloc: _notificationCubit,
                  buildWhen: (previous, current) =>
                      previous.getListNotificationsStatus != current.getListNotificationsStatus ||
                      previous.listNotifications != current.listNotifications ||
                      previous.getMoreNotificationsStatus != current.getMoreNotificationsStatus,
                  builder: (context, state) {
                    if (state.getListNotificationsStatus == LoadStatus.loading) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 10.h),
                        child: Column(children: List.generate(3, (index) => const NotificationLoadingItemWidget())),
                      );
                    }

                    if (state.getListNotificationsStatus == LoadStatus.failure) {
                      return NotificationErrorWidget(message: state.getListNotificationsMessage ?? "");
                    }

                    if (state.getListNotificationsStatus == LoadStatus.success) {
                      if (state.listNotifications.isNotEmpty) {
                        return AppLoadMore(
                          onRefresh: () {
                            _notificationCubit.getListNotifications();
                          },
                          onLoadMore: () {
                            _notificationCubit.getMoreListNotifications();
                          },
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 10.h),
                            child: Column(
                              children: [
                                Column(
                                  children: List.generate(
                                    state.listNotifications.length,
                                    (index) => NotificationItemWidget(item: state.listNotifications[index]),
                                  ),
                                ),
                                if (state.getMoreNotificationsStatus == LoadStatus.loading)
                                  Container(
                                    margin: EdgeInsets.only(top: 15.h),
                                    child: const AppLoadingIndicator(),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }

                      return NotificationErrorWidget(message: tr("listNotificationsIsEmpty"));
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
