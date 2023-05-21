import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/core/app_functions.dart';
import 'package:social_network/core/repository/repository.dart';
import 'package:social_network/core/themes/app_text_styles.dart';
import 'package:social_network/modules/sign_in/sign_in_bloc.dart';
import 'package:social_network/modules/sign_in/sign_in_events.dart';
import 'package:social_network/modules/sign_in/sign_up_states.dart';

import '../../helpers/widgets/custom_button.dart';
import '../../helpers/widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final logInBloc = SignInBloc(
    SignInInitialState(),
    Repository(),
  );
  List<bool> valid = [true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignInBloc>(
        create: (context) => logInBloc,
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccessState) {
              context.push('/feed');
            } else if (state is SignInFailedState) {
              AppFunctions.showError(context, AppLocalizations.of(context)!.signInFail);
            }
          },
          buildWhen: (previous, current) => current is SignInInitialState || current is SignInValidateState,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(25, 40, 25, 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(AppLocalizations.of(context)!.signIn, style: AppTextStyles.boldBlack22),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      AppLocalizations.of(context)!.signInDesc,
                      style: AppTextStyles.normalBlack20,
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTextField(
                      hintText: 'Email',
                      textEditingController: emailController,
                      onChanged: (value) {
                        logInBloc.add(ChangeField(email: value));
                      },
                      isError: state is SignInValidateState ? !state.valid[0] : false,
                      errorMessage: AppLocalizations.of(context)!.requiredError,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTextField(
                      hintText: AppLocalizations.of(context)!.password,
                      textEditingController: passwordController,
                      onChanged: (value) {
                        logInBloc.add(ChangeField(password: value));
                      },
                      isPassword: true,
                      isError: state is SignInValidateState ? !state.valid[1] : false,
                      errorMessage: AppLocalizations.of(context)!.requiredError,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomButton(
                        onPressed: () {
                          logInBloc.add(SubmitSignIn());
                        },
                        text: AppLocalizations.of(context)!.signIn,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          context.push('/sign_up');
                        },
                        child: Text(AppLocalizations.of(context)!.notRegistered))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
