import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/observers/route_observer.dart';
import 'package:cinemax/presentation/screens/cinemas/cinemas_cubit.dart';
import 'package:cinemax/presentation/screens/cinemas/widget/list_cinemas_error_widget.dart';
import 'package:cinemax/presentation/screens/cinemas/widget/list_cinemas_loading_widget.dart';
import 'package:cinemax/presentation/screens/cinemas/widget/list_cinemas_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCinemasTab extends StatefulWidget {
  final int? movieId;

  const ListCinemasTab({super.key, this.movieId});

  @override
  State<ListCinemasTab> createState() => _ListCinemasTabState();
}

class _ListCinemasTabState extends State<ListCinemasTab> with AutomaticKeepAliveClientMixin, RouteAware {
  late CinemasCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<CinemasCubit>(context);
    _cubit.getListCinemas(movieId: widget.movieId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _cubit.getListCinemas(movieId: widget.movieId);
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CinemasCubit, CinemasState>(
      buildWhen: (previous, current) =>
          previous.getListCinemasStatus != current.getListCinemasStatus || previous.getMoreCinemasStatus != current.getMoreCinemasStatus,
      builder: (context, state) {
        if (state.getListCinemasStatus == LoadStatus.loading) {
          return const ListCinemasLoadingWidget();
        }

        if (state.getListCinemasStatus == LoadStatus.failure) {
          return ListCinemasErrorWidget(message: state.getListCinemasMessage ?? "");
        }

        if (state.getListCinemasStatus == LoadStatus.success) {
          return ListCinemasWidget(
            movieId: widget.movieId,
            onRefresh: () {
              _cubit.getListCinemas(movieId: widget.movieId);
            },
            onLoadMore: () {
              _cubit.getMoreListCinemas(movieId: widget.movieId);
            },
            listCinemas: state.listCinemas,
            showLoadMoreIndicator: state.getMoreCinemasStatus == LoadStatus.loading,
          );
        }

        return const SizedBox();
      },
    );
  }

  @override
  bool get wantKeepAlive => false;
}
