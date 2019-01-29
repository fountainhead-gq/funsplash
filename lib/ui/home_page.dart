import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'package:funsplash/ui/curated_page.dart';
import 'package:funsplash/ui/latest_page.dart';
import 'package:funsplash/ui/popular_page.dart';
import 'package:funsplash/ui/drawer_page.dart';
import 'package:funsplash/ui/search_list.dart';
import 'package:funsplash/utils/custom_localizations.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  _HomePageState createState() => _HomePageState(title);
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String title;
  _HomePageState(this.title);

  SearchBar searchBar;
  TabController controller;
  DateTime _lastPressedAt;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar(tabTitle) {
    return new TabBar(
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 1.0),
          insets: EdgeInsets.symmetric(horizontal: 16.0)),
      indicatorColor: Colors.orangeAccent,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: <Tab>[
        new Tab(
          // set icon to the tab
          // icon: new Icon(_icons[0]),
          text: tabTitle[0].toString(),
        ),
        new Tab(
          // icon: new Icon(_icons[1]),
          text: tabTitle[1].toString(),
        ),
        new Tab(
          // icon: new Icon(_icons[2]),
          text: tabTitle[2].toString(),
        ),
      ],
      // setup the controller
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return new TabBarView(
      // Add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
    );
  }

  TextEditingController searchQuery = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String photosLatest =
        FunsplashLocalizations.of(context).trans('photos_latest');
    final String photoPopular =
        FunsplashLocalizations.of(context).trans('photos_popular');
    final String photosCurated =
        FunsplashLocalizations.of(context).trans('photos_curated');
    final String searchTip = FunsplashLocalizations.of(context).trans('search');
    final tabTitle = [photosLatest, photosCurated, photoPopular];

    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          bottom: getTabBar(tabTitle),
          title: new Text(title),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.search),
              tooltip: searchTip,
              onPressed: () {
                _onSearch();
              },
            )
          ],
        ),
        drawer: NavigationDrawer(),
        body: WillPopScope(
          child: getTabBarView(
              <Widget>[new LatestPage(), new CuratedPage(), new PopularPage()]),
          onWillPop: _onWillPop,
        ));
  }

  Future<bool> _onWillPop() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
      //两次点击间隔超过1秒则重新计时
      _lastPressedAt = DateTime.now();
      return false;
    }
    return true;
  }

  void _onSearch() async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new SearchListPage(null);
    }));
  }
}
