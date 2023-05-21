abstract class SignInEvent {}

class SubmitSignIn extends SignInEvent {}

class ChangeField extends SignInEvent {
  final String? email;
  final String? password;

  ChangeField({this.email, this.password});
}