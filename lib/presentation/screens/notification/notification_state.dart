part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final LoadStatus getListNotificationsStatus;
  final List<NotificationResponse> listNotifications;
  final String? getListNotificationsMessage;
  final LoadStatus getMoreNotificationsStatus;
  final int total;
  final int currentPage;
  final bool hasNextPage;

  const NotificationState({
    this.getListNotificationsStatus = LoadStatus.initial,
    this.listNotifications = const [],
    this.getListNotificationsMessage,
    this.getMoreNotificationsStatus = LoadStatus.initial,
    this.total = 0,
    this.currentPage = 1,
    this.hasNextPage = false,
  });

  NotificationState copyWith({
    LoadStatus? getListNotificationsStatus,
    List<NotificationResponse>? listNotifications,
    String? getListNotificationsMessage,
    LoadStatus? getMoreNotificationsStatus,
    int? total,
    int? currentPage,
    bool? hasNextPage,
  }) {
    return NotificationState(
      getListNotificationsStatus: getListNotificationsStatus ?? this.getListNotificationsStatus,
      listNotifications: listNotifications ?? this.listNotifications,
      getListNotificationsMessage: getListNotificationsMessage ?? this.getListNotificationsMessage,
      getMoreNotificationsStatus: getMoreNotificationsStatus ?? this.getMoreNotificationsStatus,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
        getListNotificationsStatus,
        listNotifications,
        getListNotificationsMessage,
        getMoreNotificationsStatus,
        total,
        currentPage,
        hasNextPage,
      ];
}
