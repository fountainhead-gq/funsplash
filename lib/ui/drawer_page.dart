import 'package:flutter/material.dart';
import 'package:funsplash/ui/collection_page.dart';
import 'package:funsplash/ui/theme_page.dart';
import 'package:funsplash/utils/custom_localizations.dart';

class NavigationDrawer extends StatefulWidget {
  NavigationDrawer({Key key}) : super(key: key);
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    // final String settingItem =
    //     FunsplashLocalizations.of(context).trans('settings');
    final String homeItem = FunsplashLocalizations.of(context).trans('home');
    final String collectionItem =
        FunsplashLocalizations.of(context).trans('collections');
    final String themeItem = FunsplashLocalizations.of(context).trans('theme');
    final tabItem = [homeItem, collectionItem, themeItem];

    return new Scaffold(
      body: Container(
        color: Theme.of(context).copyWith().primaryColor,
        child: new Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    // FlutterLogo(
                    //   size: 48.0,
                    // ),
                    Text(
                      "",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).copyWith().primaryColor),
              ),
              getNavigationItem(Icons.home, tabItem[0], '/'),
              getNavigationItem(
                  Icons.collections, tabItem[1], CollectionsPage.routName),
              Divider(),
              getNavigationItem(
                  Icons.color_lens, tabItem[2], ChangeThemePage.routName),
              // getNavigationItem(Icons.settings, settingItem, SettingPage.routName),
              // getNavigationItem(Icons.share, "Share", SharePage.routName),
              // getNavigationItem(Icons.send, "Send", SharePage.routName),
            ],
          ),
        ),
      ),
    );
  }

  Widget getNavigationItem(IconData icon, String title, String routeName) {
    return new ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
        style: TextStyle(
          // fontFamily: Strings.fontRobotoBold,
          fontSize: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          Navigator.pop(context);
          // navigate to the route
          Navigator.of(context).pushNamed(routeName);
        });
      },
    );
  }
}
