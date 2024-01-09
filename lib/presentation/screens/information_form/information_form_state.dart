part of 'information_form_cubit.dart';

class InformationFormState extends Equatable {
  final bool isEnable;
  final String fullName;
  final String fullNameErrorMessage;
  final String email;
  final String emailErrorMessage;
  final File? avatarPhoto;

  final LoadStatus updateProfileStatus;
  final String? updateProfileMessage;

  const InformationFormState({
    this.isEnable = false,
    this.fullName = '',
    this.fullNameErrorMessage = '',
    this.email = '',
    this.emailErrorMessage = '',
    this.avatarPhoto,
    this.updateProfileStatus = LoadStatus.initial,
    this.updateProfileMessage,
  });

  InformationFormState copyWith({
    bool? isEnable,
    String? fullName,
    String? fullNameErrorMessage,
    String? email,
    String? emailErrorMessage,
    File? avatarPhoto,
    LoadStatus? updateProfileStatus,
    String? updateProfileMessage,
  }) {
    return InformationFormState(
      isEnable: isEnable ?? this.isEnable,
      fullName: fullName ?? this.fullName,
      fullNameErrorMessage: fullNameErrorMessage ?? this.fullNameErrorMessage,
      email: email ?? this.email,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      avatarPhoto: avatarPhoto ?? this.avatarPhoto,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      updateProfileMessage: updateProfileMessage,
    );
  }

  @override
  List<Object?> get props => [
        isEnable,
        fullName,
        fullNameErrorMessage,
        email,
        emailErrorMessage,
        avatarPhoto,
        updateProfileStatus,
        updateProfileMessage,
      ];
}
