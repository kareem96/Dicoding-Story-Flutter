import 'package:dicoding_story_flutter/src/data/data.dart';
import 'package:dicoding_story_flutter/src/di/di.dart';
import 'package:dicoding_story_flutter/src/utils/ext/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/resources.dart';
import '../../widgets/widgets.dart';
import '../pages.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      _initData();
    });
  }

  void _initData() {
    if (sl<PrefManager>().isLogin) {
      context.goToReplace(AppRoute.mainScreen);
    } else {
      context.goToReplace(AppRoute.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: Container(
        color: Palette.white,
        child: Center(
          child: SvgPicture.asset(
            Images.icLogo,
            width: context.widthInPercent(60),
          ),
        ),
      ),
    );
  }
}
