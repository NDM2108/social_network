abstract class SignUpEvent {}

class SubmitSignUp extends SignUpEvent {}

class ChangeField extends SignUpEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confirmPassword;

  ChangeField({this.firstName, this.lastName, this.email, this.password, this.confirmPassword});
}