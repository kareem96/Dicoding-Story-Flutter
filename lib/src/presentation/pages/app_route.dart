import 'package:dicoding_story_flutter/src/di/di.dart';
import 'package:dicoding_story_flutter/src/presentation/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/auth.dart';
import 'main/main.dart';

class AppRoute {
  AppRoute._();

  static const String splashScreen = "splashscreen";
  static const String mainScreen = "main";

  //auth
  static const String login = "auth/login";
  static const String register = "auth/register";

  static Map<String, WidgetBuilder> getRoutes({RouteSettings? settings}) => {
        splashScreen: (_) => const SplashScreenPage(),
        mainScreen: (_) {
          return BlocProvider(
            create: (_) => sl<NavDrawerCubit>(),
            child: const MainPage(),
          );
        },
        login: (_) => BlocProvider(
              create: (_) => sl<LoginCubit>(),
              child: const LoginPage(),
            )
      };
}
