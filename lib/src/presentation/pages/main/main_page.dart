import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/data/data.dart';
import 'package:dicoding_story_flutter/src/di/di.dart';
import 'package:dicoding_story_flutter/src/presentation/pages/main/main.dart';
import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:dicoding_story_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<DataHelper> _dataMenus;
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dataMenus = [
      DataHelper(
        title: Strings.of(context)!.dashboard,
        isSelected: true,
      ),
      DataHelper(
        title: Strings.of(context)!.settings,
      ),
      DataHelper(
        title: Strings.of(context)!.logout,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log.d("onBackPressed");
        if (_dataMenus[_currentIndex].title == Strings.of(context)!.dashboard) {
          log.d("true");
          return true;
        } else {
          log.d("false");
          if (_scaffoldKey.currentState!.isEndDrawerOpen) {
            ///hide navigation drawer
            _scaffoldKey.currentState!.openDrawer();
          } else {
            context.read<NavDrawerCubit>().openDrawer(Navigation.dashboardPage);
            for (final menu in _dataMenus) {
              setState(() {
                menu.isSelected = menu.title == Strings.of(context)!.dashboard;
              });
            }
          }
          return false;
        }
      },
      child: Parent(
        scaffoldKey: _scaffoldKey,
        appBar: _appbar(),
        drawer: SizedBox(
          width: context.widthInPercent(80),
          child: MenuDrawer(
            dataMenu: _dataMenus,
            currentIndex: (int index){
              if(index != 2){
                setState(() {
                  _currentIndex = index;
                });
              }
              _scaffoldKey.currentState?.openDrawer();
            },
            onLogoutPressed: (){
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                      Strings.of(context)!.logout,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    content: Text(
                      Strings.of(context)!.logoutDesc,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => context.back(),
                          child: Text(
                            Strings.of(context)!.cancel,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Palette.hint),
                          )
                      ),
                      TextButton(
                          onPressed: (){
                            sl<PrefManager>().logout();
                            context.goToClearStack(AppRoute.login);
                          },
                          child: Text(
                            Strings.of(context)!.yes,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Palette.red),
                          )
                      )
                    ],
                  )
              );
            },
          ),
        ),
        child: BlocBuilder<NavDrawerCubit, Widget>(
          builder: (context, navigationState){
            return navigationState;
          },
        ),
      ),
    );
  }

  PreferredSize _appbar() {
    return PreferredSize(
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            _dataMenus[_currentIndex].title ?? "-",
          ),
          leading: IconButton(
            icon: Icon(
              Icons.sort,
              size: Dimens.space24,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        preferredSize: const Size.fromHeight(kToolbarHeight));
  }
}
