import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';


class Loading extends StatelessWidget {
  final bool showMessage;

  const Loading({Key? key, this.showMessage = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ColorLoader(),
          Visibility(
            visible: showMessage,
              child: Text(
                Strings.of(context)!.pleaseWait,
                style: Theme.of(context).textTheme.bodyText2,
              )
          )
        ],
      ),
    );
  }
}
