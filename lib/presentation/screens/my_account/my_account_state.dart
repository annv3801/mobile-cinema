part of 'my_account_cubit.dart';

class MyAccountState extends Equatable {
  final LoadStatus getUserProfileStatus;
  final UserResponse? userProfile;

  final LoadStatus logoutStatus;

  const MyAccountState({
    this.getUserProfileStatus = LoadStatus.initial,
    this.userProfile,
    this.logoutStatus = LoadStatus.initial,
  });

  MyAccountState copyWith({
    LoadStatus? getUserProfileStatus,
    UserResponse? userProfile,
    LoadStatus? logoutStatus,
  }) {
    return MyAccountState(
      getUserProfileStatus: getUserProfileStatus ?? this.getUserProfileStatus,
      userProfile: userProfile ?? this.userProfile,
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }

  @override
  List<Object?> get props => [
        getUserProfileStatus,
        userProfile,
        logoutStatus,
      ];
}
