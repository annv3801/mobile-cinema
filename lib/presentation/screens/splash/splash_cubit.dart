import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/data/data_sources/storages/shared_preferences.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_cubit.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  final _accountCubit = getIt<MyAccountCubit>();

  Future<void> onCheckLoggedInfo() async {
    try {
      emit(state.copyWith(checkLoggedInfoStatus: LoadStatus.loading));
      final accessToken = await SharedPreferencesHelper.getStringValue(SharedPreferencesHelper.userToken);
      if (accessToken.isNotEmpty) {
        final isSuccess = await _accountCubit.getUserProfile(forceRefresh: true);
        if (isSuccess) {
          emit(state.copyWith(checkLoggedInfoStatus: LoadStatus.success));
          return;
        }

        await SharedPreferencesHelper.removeByKey(SharedPreferencesHelper.userToken);
        emit(state.copyWith(checkLoggedInfoStatus: LoadStatus.failure));
        return;
      }

      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(checkLoggedInfoStatus: LoadStatus.failure));
    } catch (error) {
      emit(state.copyWith(checkLoggedInfoStatus: LoadStatus.failure));
    }
  }
}
