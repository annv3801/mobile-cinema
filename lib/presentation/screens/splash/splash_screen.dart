import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/domain/models/arguments/booking_seat_arguments.dart';
import 'package:cinemax/domain/models/arguments/home_tab_arguments.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SplashCubit>(context);
    _cubit.onCheckLoggedInfo();
  }

  void removeSplash() {
    Future.delayed(const Duration(seconds: 1), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      bloc: _cubit,
      listenWhen: (previous, current) => previous.checkLoggedInfoStatus != current.checkLoggedInfoStatus,
      listener: (context, state) {
        if (state.checkLoggedInfoStatus == LoadStatus.success) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.homeTab,
            (route) => false,
            arguments: const HomeTabArguments(index: 0),
          );
          removeSplash();
        }

        if (state.checkLoggedInfoStatus == LoadStatus.failure) {
          Navigator.of(context).pushNamedAndRemoveUntil(RouteName.login, (route) => false);
          removeSplash();
        }
      },
      child: const SizedBox(),
    );
  }
}
