import 'package:dicoding_story_flutter/src/di/di.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:dicoding_story_flutter/src/presentation/pages/main/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings/settings_page.dart';

enum Navigation {
  dashboardPage,
  settingsPage,
}

class NavDrawerCubit extends Cubit<Widget> {
  NavDrawerCubit()
      : super(
          BlocProvider(
            create: (_) => sl<StoriesCubit>()..fetchStories(StoriesParams()),
            child: const DashboardPage(),
          ),
        );

  void openDrawer(Navigation event) {
    switch (event) {
      case Navigation.dashboardPage:
        emit(
          BlocProvider(
            create: (_) => sl<StoriesCubit>()..fetchStories(StoriesParams()),
            child: const DashboardPage(),
          ),
        );
        break;
      case Navigation.settingsPage:
        emit(const SettingsPage());
        break;
    }
  }
}
