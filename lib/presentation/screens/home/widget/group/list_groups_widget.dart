import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/presentation/screens/home/home_cubit.dart';
import 'package:cinemax/presentation/screens/home/widget/group/group_item_widget.dart';
import 'package:cinemax/presentation/screens/home/widget/group/group_loading_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListGroupsWidget extends StatefulWidget {
  const ListGroupsWidget({super.key});

  @override
  State<ListGroupsWidget> createState() => _ListGroupsWidgetState();
}

class _ListGroupsWidgetState extends State<ListGroupsWidget> {
  final _homeCubit = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _homeCubit,
      buildWhen: (previous, current) => previous.getListGroupsStatus != current.getListGroupsStatus,
      builder: (context, state) {
        if (state.getListGroupsStatus == LoadStatus.loading) {
          return Column(
            children: List.generate(2, (index) {
              return Container(
                margin: EdgeInsets.only(bottom: 25.h),
                child: const GroupLoadingItemWidget(),
              );
            }),
          );
        }

        if (state.getListGroupsStatus == LoadStatus.success) {
          return Column(
            children: List.generate(state.listGroups.length, (index) {
              return BlocProvider(
                create: (context) => HomeCubit(),
                child: GroupItemWidget(group: state.listGroups[index]),
              );
            }),
          );
        }

        return const SizedBox();
      },
    );
  }
}
