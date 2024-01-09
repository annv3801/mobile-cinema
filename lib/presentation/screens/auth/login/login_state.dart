part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String phoneNumber;
  final String password;
  final bool showPassword;
  final bool isEnable;
  final LoadStatus loginStatus;
  final String? loginMessage;

  const LoginState({
    this.phoneNumber = "",
    this.password = "",
    this.showPassword = false,
    this.isEnable = false,
    this.loginStatus = LoadStatus.initial,
    this.loginMessage,
  });

  LoginState copyWith({
    String? phoneNumber,
    String? password,
    bool? showPassword,
    bool? isEnable,
    LoadStatus? loginStatus,
    String? loginMessage,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      isEnable: isEnable ?? this.isEnable,
      loginStatus: loginStatus ?? this.loginStatus,
      loginMessage: loginMessage ?? this.loginMessage,
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        password,
        showPassword,
        isEnable,
        loginStatus,
        loginMessage,
      ];
}
