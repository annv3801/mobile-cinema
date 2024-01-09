import 'package:cinemax/data/data_sources/bloc/app_cubit.dart';
import 'package:cinemax/data/repositories/auth_repository_impl.dart';
import 'package:cinemax/data/repositories/booking_repository_impl.dart';
import 'package:cinemax/data/repositories/cinemas_repository_impl.dart';
import 'package:cinemax/data/repositories/home_repository_impl.dart';
import 'package:cinemax/data/repositories/movies_repository_impl.dart';
import 'package:cinemax/data/repositories/news_repository_impl.dart';
import 'package:cinemax/data/repositories/notifications_repository_impl.dart';
import 'package:cinemax/data/repositories/user_repository_impl.dart';
import 'package:cinemax/domain/repositories/auth_repository.dart';
import 'package:cinemax/domain/repositories/booking_repository.dart';
import 'package:cinemax/domain/repositories/cinemas_repository.dart';
import 'package:cinemax/domain/repositories/home_repository.dart';
import 'package:cinemax/domain/repositories/movies_repository.dart';
import 'package:cinemax/domain/repositories/news_repository.dart';
import 'package:cinemax/domain/repositories/notifications_repository.dart';
import 'package:cinemax/domain/repositories/user_repository.dart';
import 'package:cinemax/presentation/screens/home/home_cubit.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_cubit.dart';
import 'package:cinemax/presentation/screens/notification/notification_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  getIt.init();

  // cubit
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit());
  getIt.registerLazySingleton<NotificationCubit>(() => NotificationCubit());
  getIt.registerLazySingleton<MyAccountCubit>(() => MyAccountCubit());

  // repository
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl());
  getIt.registerLazySingleton<CinemasRepository>(() => CinemasRepositoryImpl());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  getIt.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl());
  getIt.registerLazySingleton<NotificationsRepository>(() => NotificationsRepositoryImpl());
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  getIt.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl());
}