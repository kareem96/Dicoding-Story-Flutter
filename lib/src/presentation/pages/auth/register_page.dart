import 'package:dicoding_story_flutter/main.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:dicoding_story_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';
import 'cubit/cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerPasswordRepeat = TextEditingController();

  ///focus node
  final _fnName = FocusNode();
  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();
  final _fnPasswordRepeat = FocusNode();

  ///handle sate visibility password
  bool _isPasswordHide = true;
  bool _isPasswordRepeatHide = true;

  ///global key form
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: const MyAppBar().call(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (_, state) {
          switch (state.status) {
            case RegisterStatus.loading:
              context.show();
              break;
            case RegisterStatus.success:
              context.dismiss();
              context.back();
              break;
            case RegisterStatus.failure:
              context.dismiss();
              state.message.toString().toToastError();
              break;
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimens.space24),
              child: Form(
                key: _keyForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Images.icLogo,
                      width: context.widthInPercent(50),
                      color: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          ?.color,
                    ),
                    const SpacerVertical(),
                    TextForm(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            ?.color,
                      ),
                      key: const Key("name"),
                      curFocusNode: _fnName,
                      nextFocusNode: _fnEmail,
                      textInputAction: TextInputAction.next,
                      controller: _controllerName,
                      keyboardType: TextInputType.name,
                      hintText: "Jhon",
                      hint: Strings.of(context)!.name,
                    ),
                    TextForm(
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            ?.color,
                      ),
                      key: const Key("email"),
                      curFocusNode: _fnEmail,
                      nextFocusNode: _fnPassword,
                      textInputAction: TextInputAction.next,
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "jhon@gmail.com",
                      hint: Strings.of(context)!.email,
                      validator: (String? value) =>
                      value != null
                          ? (!value.isValidEmail()
                          ? Strings
                          .of(context)
                          ?.errorInvalidEmail
                          : null)
                          : null,
                    ),
                    TextForm(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            ?.color,
                      ),
                      key: const Key("password"),
                      curFocusNode: _fnPassword,
                      nextFocusNode: _fnPasswordRepeat,
                      textInputAction: TextInputAction.next,
                      controller: _controllerPassword,
                      keyboardType: TextInputType.text,
                      hintText: "••••••••••••",
                      maxLine: 1,
                      obscureText: _isPasswordHide,
                      hint: Strings.of(context)!.password,
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            _isPasswordHide = !_isPasswordHide;
                          });
                        },
                        icon: Icon(_isPasswordHide
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      validator: (String? value) =>
                      value != null
                          ? (value.length <= 6
                          ? Strings
                          .of(context)
                          ?.errorEmptyField
                          : null)
                          : null,
                    ),
                    TextForm(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            ?.color,
                      ),
                      key: const Key("password_repeat"),
                      curFocusNode: _fnPasswordRepeat,
                      textInputAction: TextInputAction.done,
                      controller: _controllerPasswordRepeat,
                      keyboardType: TextInputType.text,
                      hintText: "••••••••••••",
                      maxLine: 1,
                      obscureText: _isPasswordRepeatHide,
                      hint: Strings.of(context)!.passwordRepeat,
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            _isPasswordRepeatHide = !_isPasswordRepeatHide;
                          });
                        },
                        icon: Icon(_isPasswordRepeatHide
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      validator: (String? value) =>
                      value != null
                          ? (value != _controllerPassword.text
                          ? Strings
                          .of(context)
                          ?.errorPasswordNotMatch
                          : null)
                          : null,
                    ),
                    SpacerVertical(
                      value: Dimens.space24,
                    ),
                    Button(
                        title: Strings.of(context)!.register,
                        onPressed: () {
                          if (_keyForm.currentState?.validate() ?? false) {
                            context
                                .read<RegisterCubit>()
                                .register(RegisterParams(
                                name: _controllerName.text,
                                email: _controllerEmail.text,
                                password: _controllerPassword.text,
                            ));
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
