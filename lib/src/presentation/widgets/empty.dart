import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:dicoding_story_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String? errorMessage;

  const Empty({Key? key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Images.icLauncher, width: context.widthInPercent(45),),
        Text(errorMessage ?? Strings.of(context)!.errorNoData)
      ],
    );
  }
}
