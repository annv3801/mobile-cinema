import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/application/utils/validators.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/request/auth/login_request.dart';
import 'package:cinemax/domain/repositories/auth_repository.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_cubit.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final _authRepository = getIt<AuthRepository>();
  final _accountCubit = getIt<MyAccountCubit>();

  void onChangePhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber.trim()));
  }

  void onChangePassword(String password) {
    emit(state.copyWith(password: password.trim()));
  }

  void onChangeShowPassword(bool showPassword) {
    emit(state.copyWith(showPassword: showPassword));
  }

  void checkEnableButton() {
    if (state.phoneNumber.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(isEnable: false));
      return;
    }

    if (!Validators.validatePhone(state.phoneNumber)) {
      emit(state.copyWith(isEnable: false));
      return;
    }

    emit(state.copyWith(isEnable: true));
  }

  Future<void> login() async {
    try {
      emit(state.copyWith(loginStatus: LoadStatus.loading));
      final params = LoginRequest(phoneNumber: state.phoneNumber, password: state.password);
      final response = await _authRepository.login(params);

      if (response.isRight) {
        _accountCubit.getUserProfile(forceRefresh: true);
        emit(state.copyWith(loginStatus: LoadStatus.success));
        return;
      }
      emit(state.copyWith(loginStatus: LoadStatus.failure, loginMessage: response.left));
    } catch (error) {
      emit(state.copyWith(loginStatus: LoadStatus.failure, loginMessage: error.toMessage));
    }
  }
}
