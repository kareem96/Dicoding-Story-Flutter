import 'package:flutter/material.dart';

import '../resources/resources.dart';

class SpacerHorizontal extends StatelessWidget {
  final double? value;
  const SpacerHorizontal({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: value ?? Dimens.space8,
    );
  }
}
