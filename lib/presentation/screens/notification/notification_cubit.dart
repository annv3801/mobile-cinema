import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/response/notifications/notification_response.dart';
import 'package:cinemax/domain/repositories/notifications_repository.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());

  final _notificationsRepository = getIt<NotificationsRepository>();

  Future<void> getListNotifications() async {
    try {
      emit(state.copyWith(getListNotificationsStatus: LoadStatus.loading));

      final response = await _notificationsRepository.getListNotifications(1);

      if (response.isRight) {
        emit(state.copyWith(
          getListNotificationsStatus: LoadStatus.success,
          listNotifications: response.right.data,
          currentPage: response.right.currentPage,
          total: response.right.total,
          hasNextPage: response.right.currentPage < response.right.lastPage,
        ));
        return;
      }

      emit(state.copyWith(getListNotificationsStatus: LoadStatus.failure));
    } catch (error) {
      emit(state.copyWith(getListNotificationsStatus: LoadStatus.failure));
    }
  }

  Future<void> getMoreListNotifications() async {
    try {
      if (!state.hasNextPage || state.getMoreNotificationsStatus == LoadStatus.loading) return;

      emit(state.copyWith(getMoreNotificationsStatus: LoadStatus.loading));
      final response = await _notificationsRepository.getListNotifications(state.currentPage + 1);

      if (response.isRight) {
        emit(state.copyWith(
          getMoreNotificationsStatus: LoadStatus.success,
          listNotifications: [...state.listNotifications, ...response.right.data],
          currentPage: response.right.currentPage,
          total: response.right.total,
          hasNextPage: response.right.currentPage < response.right.lastPage,
        ));
        return;
      }

      emit(state.copyWith(getMoreNotificationsStatus: LoadStatus.failure));
    } catch (error) {
      emit(state.copyWith(getMoreNotificationsStatus: LoadStatus.failure));
    }
  }
}
