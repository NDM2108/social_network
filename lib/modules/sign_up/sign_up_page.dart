import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/repository/repository.dart';
import 'package:social_network/core/themes/app_text_styles.dart';
import 'package:social_network/modules/sign_up/sign_up_bloc.dart';
import 'package:social_network/modules/sign_up/sign_up_events.dart';
import 'package:social_network/modules/sign_up/sign_up_states.dart';

import '../../helpers/widgets/custom_button.dart';
import '../../helpers/widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final signUpBloc = SignUpBloc(SignUpInitialState(), Repository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignUpBloc>(
        create: (context) => signUpBloc,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 40, 25, 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(AppLocalizations.of(context)!.signUp, style: AppTextStyles.boldBlack22),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  AppLocalizations.of(context)!.signUpDesc,
                  style: AppTextStyles.normalBlack20,
                ),
                const SizedBox(
                  height: 36,
                ),
                CustomTextField(
                  hintText: 'First Name',
                  textEditingController: firstNameController,
                  onChanged: (value) {
                    signUpBloc.add(ChangeField(firstName: value));
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hintText: 'Last Name',
                  textEditingController: lastNameController,
                  onChanged: (value) {
                    signUpBloc.add(ChangeField(lastName: value));
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hintText: 'Email',
                  textEditingController: emailController,
                  onChanged: (value) {
                    signUpBloc.add(ChangeField(email: value));
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hintText: 'Password',
                  textEditingController: passwordController,
                  onChanged: (value) {
                    signUpBloc.add(ChangeField(password: value));
                  },
                  isPassword: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hintText: 'Confirm Password',
                  textEditingController: rePasswordController,
                  onChanged: (value) {
                    signUpBloc.add(ChangeField(confirmPassword: value));
                  },
                  isPassword: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () {
                      signUpBloc.add(SubmitSignUp());
                    },
                    text: 'Sign up',
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('Do you have an account? Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
