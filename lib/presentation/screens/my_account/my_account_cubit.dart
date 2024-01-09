import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/data/data_sources/storages/shared_preferences.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/response/user/user_response.dart';
import 'package:cinemax/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  MyAccountCubit() : super(const MyAccountState());

  final _userRepository = getIt<UserRepository>();

  /// return true if get profile success - false if get profile error
  Future<bool> getUserProfile({bool forceRefresh = false}) async {
    try {
      if (state.userProfile != null && !forceRefresh) return true;
      emit(state.copyWith(getUserProfileStatus: LoadStatus.loading));

      final response = await _userRepository.getUserProfile();
      if (response.isRight) {
        await SharedPreferencesHelper.saveIntValue(SharedPreferencesHelper.accountId, response.right.id);
        emit(state.copyWith(getUserProfileStatus: LoadStatus.success, userProfile: response.right));
        return true;
      }

      emit(state.copyWith(getUserProfileStatus: LoadStatus.failure));
      return false;
    } catch (error) {
      emit(state.copyWith(getUserProfileStatus: LoadStatus.failure));
      return false;
    }
  }

  Future<void> logout() async {
    try {
      if(state.logoutStatus == LoadStatus.loading) return;

      emit(state.copyWith(logoutStatus: LoadStatus.loading));

      await SharedPreferencesHelper.removeByKey(SharedPreferencesHelper.userToken);
      await SharedPreferencesHelper.removeByKey(SharedPreferencesHelper.accountId);

      emit(state.copyWith(logoutStatus: LoadStatus.success));
    } catch (error) {
      emit(state.copyWith(logoutStatus: LoadStatus.failure));
    }
  }
}
