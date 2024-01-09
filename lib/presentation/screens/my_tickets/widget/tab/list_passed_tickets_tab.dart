import 'package:cinemax/application/enums/booking_status.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/presentation/screens/my_tickets/my_tickets_cubit.dart';
import 'package:cinemax/presentation/screens/my_tickets/widget/list_tickets_error_widget.dart';
import 'package:cinemax/presentation/screens/my_tickets/widget/list_tickets_loading_widget.dart';
import 'package:cinemax/presentation/screens/my_tickets/widget/list_tickets_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPassedTicketsTab extends StatefulWidget {
  const ListPassedTicketsTab({super.key});

  @override
  State<ListPassedTicketsTab> createState() => _ListPassedTicketsTabState();
}

class _ListPassedTicketsTabState extends State<ListPassedTicketsTab>  with AutomaticKeepAliveClientMixin{
  late MyTicketsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<MyTicketsCubit>(context);
    _cubit.getListBookings(BookingStatus.passed);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MyTicketsCubit, MyTicketsState>(
      buildWhen: (previous, current) => previous.getListBookingStatus != current.getListBookingStatus,
      builder: (_, state) {
        if (state.getListBookingStatus == LoadStatus.loading) {
          return const ListTicketsLoadingWidget();
        }

        if (state.getListBookingStatus == LoadStatus.failure) {
          return ListTicketsErrorWidget(message: state.getListBookingMessage ?? "");
        }

        if (state.getListBookingStatus == LoadStatus.success) {
          return ListTicketsWidget(
            onRefresh: () {
              _cubit.getListBookings(BookingStatus.passed);
            },
            onLoadMore: () {
              _cubit.getMoreListBookings(BookingStatus.passed);
            },
            listBookings: state.listBookings,
          );
        }

        return const SizedBox();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
