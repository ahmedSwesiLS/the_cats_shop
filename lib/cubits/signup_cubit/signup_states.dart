abstract class SignupState {
  const SignupState({this.successMessage, this.errorMessage});

  final String? successMessage, errorMessage;
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignUpSuccess extends SignupState {
  SignUpSuccess({required String successMessage})
      : super(successMessage: successMessage);
}

class SignupFailure extends SignupState {
  SignupFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}
