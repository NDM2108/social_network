import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/repository/repository.dart';
import 'package:social_network/helpers/request/sign_up_request.dart';
import 'package:social_network/modules/sign_up/sign_up_events.dart';
import 'package:social_network/modules/sign_up/sign_up_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  Repository repository;

  SignUpBloc(SignUpState initialState, this.repository) : super(initialState) {
    on<SubmitSignUp>(_onSubmit);
    on<ChangeField>(_onChangeField);
  }

  void _onChangeField(ChangeField event, Emitter<SignUpState> emit) async {
    if (event.firstName != null) {
      firstName = event.firstName!;
    }
    if (event.lastName != null) {
      lastName = event.lastName!;
    }
    if (event.email != null) {
      email = event.email!;
    }
    if (event.password != null) {
      password = event.password!;
    }
    if (event.confirmPassword != null) {
      confirmPassword = event.confirmPassword!;
    }
  }

  void _onSubmit(SubmitSignUp event, Emitter<SignUpState> emit) async {
    await repository.register(
        SignUpRequest(firstName: firstName, lastName: lastName, email: email, password: password)
            .toJson());
    emit(SignUpSuccessState());
  }
}
