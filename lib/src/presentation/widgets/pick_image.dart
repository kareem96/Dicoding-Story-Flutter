import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:flutter/material.dart';

class PickImage extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onClick;
  const PickImage({
    Key? key,
    required this.title,
    this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(56),
        primary: Theme.of(context).primaryColor,
        onPrimary: Theme.of(context).primaryColorLight,
        textStyle: TextStyle(fontSize: 20)
      ),
        child: Row(
          children: [
            Icon(icon, size: Dimens.space24,),
            SizedBox(width: Dimens.space16,),
            Text(title)
          ],
        ),
        onPressed: onClick,
    );
  }
}
