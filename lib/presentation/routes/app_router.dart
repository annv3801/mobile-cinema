import 'package:cinemax/domain/models/arguments/booking_checkout_arguments.dart';
import 'package:cinemax/domain/models/arguments/booking_detail_arguments.dart';
import 'package:cinemax/domain/models/arguments/booking_room_arguments.dart';
import 'package:cinemax/domain/models/arguments/booking_seat_arguments.dart';
import 'package:cinemax/domain/models/arguments/cinema_detail_arguments.dart';
import 'package:cinemax/domain/models/arguments/cinemas_arguments.dart';
import 'package:cinemax/domain/models/arguments/home_tab_arguments.dart';
import 'package:cinemax/domain/models/arguments/list_movies_arguments.dart';
import 'package:cinemax/domain/models/arguments/movie_detail_arguments.dart';
import 'package:cinemax/domain/models/arguments/news_detail_arguments.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/auth/login/login_cubit.dart';
import 'package:cinemax/presentation/screens/auth/login/login_screen.dart';
import 'package:cinemax/presentation/screens/booking_checkout/booking_checkout_cubit.dart';
import 'package:cinemax/presentation/screens/booking_checkout/booking_checkout_screen.dart';
import 'package:cinemax/presentation/screens/booking_detail/booking_detail_cubit.dart';
import 'package:cinemax/presentation/screens/booking_detail/booking_detail_screen.dart';
import 'package:cinemax/presentation/screens/booking_room/booking_room_cubit.dart';
import 'package:cinemax/presentation/screens/booking_room/booking_room_screen.dart';
import 'package:cinemax/presentation/screens/booking_seat/booking_seat_cubit.dart';
import 'package:cinemax/presentation/screens/booking_seat/booking_seat_screen.dart';
import 'package:cinemax/presentation/screens/cinema_detail/cinema_detail_cubit.dart';
import 'package:cinemax/presentation/screens/cinema_detail/cinema_detail_screen.dart';
import 'package:cinemax/presentation/screens/cinemas/cinemas_screen.dart';
import 'package:cinemax/presentation/screens/home_tab/home_tab_screen.dart';
import 'package:cinemax/presentation/screens/information_form/information_form_cubit.dart';
import 'package:cinemax/presentation/screens/information_form/information_form_screen.dart';
import 'package:cinemax/presentation/screens/list_favorites/list_favorites_screen.dart';
import 'package:cinemax/presentation/screens/list_movies/list_movies_cubit.dart';
import 'package:cinemax/presentation/screens/list_movies/list_movies_screen.dart';
import 'package:cinemax/presentation/screens/movie_detail/movie_detail_cubit.dart';
import 'package:cinemax/presentation/screens/movie_detail/movie_detail_screen.dart';
import 'package:cinemax/presentation/screens/news_detail/news_detail_cubit.dart';
import 'package:cinemax/presentation/screens/news_detail/news_detail_screen.dart';
import 'package:cinemax/presentation/screens/splash/splash_cubit.dart';
import 'package:cinemax/presentation/screens/splash/splash_screen.dart';
import 'package:cinemax/presentation/screens/vnpay_payment/vnpay_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    Widget initialWidget = BlocProvider(
      create: (context) => SplashCubit(),
      child: const SplashScreen(),
    );

    Widget routeWidget = initialWidget;
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case RouteName.login:
        routeWidget = BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        );
        break;
      case RouteName.homeTab:
        routeWidget = HomeTabScreen(arguments: arguments as HomeTabArguments);
        break;
      case RouteName.movieDetail:
        routeWidget = BlocProvider(
          create: (context) => MovieDetailCubit(),
          child: MovieDetailScreen(arguments: arguments as MovieDetailArguments),
        );
        break;
      case RouteName.chooseCinema:
        routeWidget = CinemasScreen(arguments: arguments as CinemasArguments);
        break;
      case RouteName.listMovies:
        routeWidget = BlocProvider(
          create: (context) => ListMoviesCubit(),
          child: ListMoviesScreen(arguments: arguments as ListMoviesArguments),
        );
        break;
      case RouteName.cinemaDetail:
        routeWidget = BlocProvider(
          create: (context) => CinemaDetailCubit(),
          child: CinemaDetailScreen(arguments: arguments as CinemaDetailArguments),
        );
        break;

      case RouteName.bookingRoom:
        routeWidget = BlocProvider(
          create: (context) => BookingRoomCubit(),
          child: BookingRoomScreen(arguments: arguments as BookingRoomArguments),
        );
        break;

      case RouteName.bookingSeat:
        routeWidget = BlocProvider(
          create: (context) => BookingSeatCubit(),
          child: BookingSeatScreen(arguments: arguments as BookingSeatArguments),
        );
        break;
      case RouteName.informationForm:
        routeWidget = BlocProvider(
          create: (context) => InformationFormCubit(),
          child: const InformationFormScreen(),
        );
        break;
      case RouteName.bookingCheckout:
        routeWidget = BlocProvider(
          create: (context) => BookingCheckoutCubit(),
          child: BookingCheckoutScreen(arguments: arguments as BookingCheckoutArguments),
        );
        break;
      case RouteName.bookingDetail:
        routeWidget = BlocProvider(
          create: (context) => BookingDetailCubit(),
          child: BookingDetailScreen(arguments: arguments as BookingDetailArguments),
        );
        break;
      case RouteName.vnPayPayment:
        routeWidget = VnPayPaymentScreen(url: arguments as Uri);
        break;
      case RouteName.listFavorites:
        routeWidget = const ListFavoritesScreen();
        break;
      case RouteName.newsDetail:
        routeWidget = BlocProvider(
          create: (context) => NewsDetailCubit(),
          child: NewsDetailScreen(arguments: arguments as NewsDetailArguments),
        );
        break;
      default:
        routeWidget = initialWidget;
        break;
    }

    return MaterialPageRoute(builder: (_) => routeWidget, settings: routeSettings);
  }
}
