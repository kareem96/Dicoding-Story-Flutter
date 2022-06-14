import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/data/data.dart';
import 'package:dicoding_story_flutter/src/di/di.dart';
import 'package:dicoding_story_flutter/src/presentation/pages/main/main.dart';
import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:dicoding_story_flutter/src/presentation/widgets/drop_down.dart';
import 'package:dicoding_story_flutter/src/utils/helper/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late List<String> _themeList;
  late List<DataHelper> _languageList;

  String _selectedTheme = "";
  late DataHelper _selectedLanguage;
  late SettingsCubit _settingsCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _settingsCubit = BlocProvider.of(context);
    _themeList = [
      Strings.of(context)!.themeLight,
      Strings.of(context)!.themeDark,
      Strings.of(context)!.themeSystem,
    ];
    _languageList = [
      DataHelper(title: Constants.get.english, type: "en"),
      DataHelper(title: Constants.get.bahasa, type: "id"),
    ];

    if (sl<PrefManager>().theme == describeEnum(ActiveTheme.system)) {
      _selectedTheme = Strings.of(context)!.themeSystem;
    } else if (sl<PrefManager>().theme == describeEnum(ActiveTheme.light)) {
      _selectedTheme = Strings.of(context)!.themeLight;
    } else {
      _selectedTheme = Strings.of(context)!.themeDark;
    }

    //filter if selected locale is EN
    _selectedLanguage =
        sl<PrefManager>().locale == "en" ? _languageList[0] : _languageList[1];
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimens.space16),
          child: Column(
            children: [
              DropDown(
                key: const Key("dropdown_theme"),
                hint: Strings.of(context)!.chooseTheme,
                value: _selectedTheme,
                prefixIcon: const Icon(Icons.light),
                items: _themeList
                    .map((data) => DropdownMenuItem(
                        value: data,
                        child: Text(
                          data,
                          style: Theme.of(context).textTheme.bodyText2,
                        )))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    final _theme = value as String;
                    ActiveTheme activeTheme;
                    if (_theme == Strings.of(context)!.themeLight) {
                      activeTheme = ActiveTheme.light;
                    } else if (_theme == Strings.of(context)!.themeDark) {
                      activeTheme = ActiveTheme.dark;
                    } else {
                      activeTheme = ActiveTheme.system;
                    }

                    ///update theme status in sharedPref
                    sl<PrefManager>().theme = describeEnum(activeTheme);

                    ///reload theme
                    _settingsCubit.reloadWidget();
                  }
                },
              ),

              /// language
              DropDown(
                key: const Key("dropdown_language"),
                value: _selectedLanguage,
                hint: Strings.of(context)!.chooseLanguage,
                prefixIcon: const Icon(Icons.language_outlined),
                items: _languageList
                    .map(
                      (data) => DropdownMenuItem(
                        value: data,
                        child: Text(
                          data.title ?? "-",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) async {
                  if (value != null) {
                    _selectedLanguage = value as DataHelper;

                    ///update locale code
                    sl<PrefManager>().locale = _selectedLanguage.type;

                    ///reload language
                    if (!mounted) return;
                    _settingsCubit.reloadWidget();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
