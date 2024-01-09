import 'package:cinemax/application/observers/route_observer.dart';
import 'package:cinemax/application/utils/navigation_utils.dart';
import 'package:cinemax/application/utils/utils.dart';
import 'package:cinemax/presentation/routes/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: (_, child) => MaterialApp(
        navigatorObservers: [routeObserver],
        navigatorKey: NavigationUtils.navigatorKey,
        // set property
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        builder: (BuildContext context, Widget? child) => GestureDetector(
          onTap: () {
            Utils.dismissKeyboard();
          },
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          ),
        ),
        locale: context.locale,
        title: 'Cinemax',
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
