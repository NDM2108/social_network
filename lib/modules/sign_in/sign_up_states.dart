abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInSuccessState extends SignInState {}

class SignInValidateState extends SignInState {
  final List<bool> valid;

  SignInValidateState({required this.valid});
}

class SignInFailedState extends SignInState {}