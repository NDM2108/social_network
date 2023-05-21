import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/repository/repository.dart';
import 'package:social_network/core/shared_preferences/shared_preferences_repository.dart';
import 'package:social_network/helpers/response/user_model.dart';
import 'package:social_network/modules/sign_in/sign_in_events.dart';
import 'package:social_network/modules/sign_in/sign_up_states.dart';
import '../../helpers/request/signin_request.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  String email = '';
  String password = '';
  Repository repository;
  List<bool> valid = [true, true];

  SignInBloc(SignInState initialState, this.repository) : super(initialState) {
    on<SubmitSignIn>(_onSubmit);
    on<ChangeField>(_onChangeField);
  }

  void _onChangeField(ChangeField event, Emitter<SignInState> emit) async {
    if (event.email != null) {
      email = event.email!;
    }
    if (event.password != null) {
      password = event.password!;
    }
  }

  void _onSubmit(SubmitSignIn event, Emitter<SignInState> emit) async {
    if (email.isEmpty) {
      valid[0] = false;
    } else {
      valid[0] = true;
    }
    if (password.isEmpty) {
      valid[1] = false;
    } else {
      valid[1] = true;
    }
    emit(SignInValidateState(valid: valid));
    if (valid[0] && valid[1]) {
      try {
        Response response =
            await repository.login(SignInRequest(email: email, password: password).toJson());
        UserModel userModel = UserModel.fromJson(response.data);
        if (userModel.token != null) {
          SharedPreferencesRepository().setAccessToken(userModel.token!);
          SharedPreferencesRepository().setUserInformation(userModel);
          emit(SignInSuccessState());
        }
      } catch (e) {
        emit(SignInFailedState());
      }
    }
  }
}
