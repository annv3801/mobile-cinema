import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/application/extensions/object_extensions.dart';
import 'package:cinemax/application/utils/validators.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/request/user/update_profile_request.dart';
import 'package:cinemax/domain/repositories/user_repository.dart';
import 'package:cinemax/presentation/screens/my_account/my_account_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'information_form_state.dart';

class InformationFormCubit extends Cubit<InformationFormState> {
  InformationFormCubit() : super(const InformationFormState());

  final _userRepository = getIt<UserRepository>();
  final _myAccountCubit = getIt<MyAccountCubit>();

  void initFormData() {
    emit(state.copyWith(
      fullName: _myAccountCubit.state.userProfile?.fullName ?? '',
      email: _myAccountCubit.state.userProfile?.email ?? '',
    ));
  }

  Future<void> onChangeAvatarPhoto() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      emit(state.copyWith(avatarPhoto: File(pickedFile.path)));
      checkEnableButton();
    }
  }

  void onChangeFullName(String fullName) {
    String fullNameErrorMessage = "";
    if (!Validators.validateFullName(fullName)) {
      fullNameErrorMessage = tr("fullNameIsInvalid");
    }

    if (fullName.trim().isEmpty) {
      fullNameErrorMessage = tr("fullNameIsEmpty");
    }

    emit(state.copyWith(fullName: fullName.trim(), fullNameErrorMessage: fullNameErrorMessage));
    checkEnableButton();
  }

  void onChangeEmail(String email) {
    String emailErrorMessage = "";
    if (!Validators.validateEmail(email)) {
      emailErrorMessage = tr("emailIsInvalid");
    }

    if (email.trim().isEmpty) {
      emailErrorMessage = tr("emailIsEmpty");
    }

    emit(state.copyWith(email: email.trim(), emailErrorMessage: emailErrorMessage));
    checkEnableButton();
  }

  void checkEnableButton() {
    emit(state.copyWith(isEnable: state.fullNameErrorMessage.isEmpty && state.emailErrorMessage.isEmpty));
  }

  Future<void> updateProfile() async {
    try {
      emit(state.copyWith(updateProfileStatus: LoadStatus.loading));

      final body = UpdateProfileRequest(
        email: state.email,
        fullName: state.fullName,
        phoneNumber: _myAccountCubit.state.userProfile?.phoneNumber ?? '',
        gender: _myAccountCubit.state.userProfile?.gender ?? false,
        avatarPhoto: state.avatarPhoto,
      );
      final response = await _userRepository.updateUserProfile(body);

      response.fold(
        (left) {
          emit(state.copyWith(
            updateProfileStatus: LoadStatus.failure,
            updateProfileMessage: left,
          ));
        },
        (right) {
          emit(state.copyWith(updateProfileStatus: LoadStatus.success));
          _myAccountCubit.getUserProfile(forceRefresh: true);
        },
      );
    } catch (error) {
      emit(state.copyWith(
        updateProfileStatus: LoadStatus.failure,
        updateProfileMessage: error.toMessage,
      ));
    }
  }
}
