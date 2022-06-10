import 'dart:developer';

import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/presentation/pages/app_route.dart';
import 'package:dicoding_story_flutter/src/presentation/pages/auth/auth.dart';
import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:dicoding_story_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/usecase/auth/auth.dart';
import '../../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();

  bool _isPasswordHide = true;

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: BlocListener<LoginCubit, LoginState>(
        listener: (_, state) {
          log.d("loginState $state");
          switch (state.status) {
            case LoginStatus.loading:
              context.show();
              break;
            case LoginStatus.success:
              context.dismiss();
              // state.login?.loginResult?.token?.toToastSuccess();
              TextInput.finishAutofillContext();
              /*context.goToReplace(AppRoute.mainScreen);*/
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Success!")
              ));
              break;
            case LoginStatus.failure:
              context.dismiss();
              state.message.toString().toToastError();
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimens.space24),
              child: AutofillGroup(
                child: Form(
                  key: _keyForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Images.icLogo,
                        width: context.widthInPercent(50),
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      ),
                      const SpacerVertical(),
                      TextForm(
                        autofillHints: const [AutofillHints.email],
                        key: const Key("email"),
                        curFocusNode: _fnEmail,
                        nextFocusNode: _fnPassword,
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                        hintText: "email@gmail.com",
                        hint: Strings.of(context)!.email,
                        validator: (String? value) => value != null
                            ? (!value.isValidEmail()
                                ? Strings.of(context)?.errorInvalidEmail
                                : null)
                            : null,
                      ),
                      TextForm(
                        autofillHints: const [AutofillHints.password],
                        key: const Key("password"),
                        curFocusNode: _fnPassword,
                        textInputAction: TextInputAction.done,
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                        obscureText: _isPasswordHide,
                        hintText: '••••••••••••',
                        maxLine: 1,
                        hint: Strings.of(context)!.password,
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            setState(
                              () {
                                _isPasswordHide = !_isPasswordHide;
                              },
                            );
                          },
                          icon: Icon(
                            _isPasswordHide
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        validator: (String? value) => value != null
                            ? (value.length < 3
                                ? Strings.of(context)!.errorEmptyField
                                : null)
                            : null,
                      ),
                      SpacerVertical(
                        value: Dimens.space24,
                      ),
                      Button(
                        title: Strings.of(context)!.login,
                        onPressed: () {
                          if(_keyForm.currentState?.validate() ?? false){
                            context.read<LoginCubit>().login(LoginParams(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
