import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:flutter/material.dart';

class SpacerVertical extends StatelessWidget {
  final double? value;
  const SpacerVertical({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: value ?? Dimens.space8,
    );
  }
}
