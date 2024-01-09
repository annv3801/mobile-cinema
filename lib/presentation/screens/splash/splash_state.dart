part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final LoadStatus checkLoggedInfoStatus;

  const SplashState({
    this.checkLoggedInfoStatus = LoadStatus.initial,
  });

  SplashState copyWith({
    LoadStatus? checkLoggedInfoStatus,
  }) {
    return SplashState(
      checkLoggedInfoStatus: checkLoggedInfoStatus ?? this.checkLoggedInfoStatus,
    );
  }

  @override
  List<Object?> get props => [
        checkLoggedInfoStatus,
      ];
}
