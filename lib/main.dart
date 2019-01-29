import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:funsplash/ui/home_page.dart';
import 'package:funsplash/ui/share_page.dart';
import 'package:funsplash/ui/collection_page.dart';
import 'package:funsplash/ui/settings_page.dart';
import 'package:funsplash/utils/theme_config.dart';
import 'package:funsplash/utils/custom_localizations.dart';
import 'package:funsplash/ui/theme_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Color themeColor = ThemeUtils.currentColorTheme;
  Locale _locale;

  @override
  void initState() {
    super.initState();
    // setLocalizedValues(localizedValues);
    // _loadLocale();
    ThemeUtils.getColorThemeIndex().then((index) {
      if (index != null) {
        ThemeUtils.currentColorTheme = ThemeUtils.supportColors[index];
        AppThemeConfig.eventBus
            .fire(new ChangeThemeEvent(ThemeUtils.supportColors[index]));
      }
    });
    AppThemeConfig.eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
  }

  // void _loadLocale() {
  //   setState(() {
  //     LanguageModel model = SpHelper.getLanguageModel();
  //     if (model != null) {
  //       _locale = new Locale(model.languageCode, model.countryCode);
  //     } else {
  //       _locale = null;
  //     }
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  final String title = 'funsplash';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: themeColor,
      ),
      home: HomePage(title: title),
      // locale: _locale,
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   CustomLocalizations.delegate
      // ],
      // supportedLocales: CustomLocalizations.supportedLocales,
      routes: <String, WidgetBuilder>{
        SharePage.routName: (BuildContext context) => new SharePage(),
        SettingPage.routName: (BuildContext context) => new SettingPage(),
        CollectionsPage.routName: (BuildContext context) =>
            new CollectionsPage(),
       ChangeThemePage.routName: (BuildContext context) =>
            new ChangeThemePage(),
      },
    );
  }
}
