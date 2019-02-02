import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:funsplash/ui/home_page.dart';
import 'package:funsplash/ui/collection_page.dart';
import 'package:funsplash/utils/theme_config.dart';
import 'package:funsplash/utils/custom_localizations.dart';
import 'package:funsplash/ui/theme_page.dart';
import 'package:funsplash/ui/about_page.dart';

void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return MyAppState();
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new HomeScreen(),
        title: new Text(
          'Welcome In Funsplash',
          style: new TextStyle(color: Colors.white70),
        ),
        image: new Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.black87,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.amber[800]);
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color themeColor = ThemeUtils.currentColorTheme;

  @override
  void initState() {
    super.initState();

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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(themeColor);
    final String title = "funsplash";
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: themeColor,
      ),
      home: HomePage(title: title),
      supportedLocales: [
        const Locale('zh', ''),
        const Locale('en', ''),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FunsplashLocalizations.delegate,
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
      },
      routes: <String, WidgetBuilder>{
        CollectionsPage.routName: (BuildContext context) =>
            new CollectionsPage(),
        ChangeThemePage.routName: (BuildContext context) =>
            new ChangeThemePage(),
        AboutPage.routName: (BuildContext context) => new AboutPage(),
      },
    );
  }
}
