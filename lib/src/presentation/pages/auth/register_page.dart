import 'package:dicoding_story_flutter/main.dart';
import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:dicoding_story_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cubit/cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerPasswordRepeat = TextEditingController();

  ///focus node
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
        listener: (_, state){
          switch (state.status){
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
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                    const SpacerVertical(),
                    Tex
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
