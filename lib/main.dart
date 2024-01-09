import 'package:cinemax/application/configs/env_configs.dart';
import 'package:cinemax/data/data_sources/api/api_client_provider.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/presentation/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await configureDependencies(); // init DI

  await EasyLocalization.ensureInitialized(); // init localization

  await EnvConfigs.init(); // init env config

  //OneSignal.initialize(EnvConfigs.oneSignalAppId); // init onesignal config

  await ApiClientProvider.init(); // init api client

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
    path: 'assets/translations',
    fallbackLocale: const Locale('vi', 'VN'),
    startLocale: const Locale('vi', 'VN'),
    child: const MyApp(),
  ));
}
