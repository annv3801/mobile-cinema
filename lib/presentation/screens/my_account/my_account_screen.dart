import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_cubit.dart';
import 'package:cinemax/presentation/screens/my_account/widget/list_menus_widget.dart';
import 'package:cinemax/presentation/screens/my_account/widget/user_information_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _cubit = getIt<MyAccountCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MyAccountCubit, MyAccountState>(
          bloc: _cubit,
          listenWhen: (previous, current) => previous.logoutStatus != current.logoutStatus,
          listener: (_, state) {
            if (state.logoutStatus == LoadStatus.success || state.logoutStatus == LoadStatus.failure) {
              Navigator.of(context).pushNamedAndRemoveUntil(RouteName.login, (route) => false);
            }
          },
        ),
      ],
      child: AppPage(
        appBar: AppHeaderBar(title: tr("yourAccount"), showClose: false),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5.h),
                const UserInformationWidget(),
                SizedBox(height: 10.h),
                const ListMenusWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
