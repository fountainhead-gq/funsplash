import 'package:flutter/material.dart';
import 'package:funsplash/ui/curated_page.dart';
import 'package:funsplash/ui/latest_page.dart';
import 'package:funsplash/ui/popular_page.dart';
import 'package:funsplash/ui/drawer_page.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:funsplash/ui/search_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  _HomePageState createState() => _HomePageState(title);
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final String title;
  _HomePageState(this.title);

  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController controller;

  final _icons = [Icons.fiber_new, Icons.timeline, Icons.whatshot];
  DateTime _lastPressedAt;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: _icons.length, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return new TabBar(
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 1.0),
          insets: EdgeInsets.symmetric(horizontal: 16.0)),
      indicatorColor: Colors.orangeAccent,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: <Tab>[
        new Tab(
          // set icon to the tab
          icon: new Icon(_icons[0]),
          // text: 'Latest',
        ),
        new Tab(
          icon: new Icon(_icons[1]),
          // text: 'Trending',
        ),
        new Tab(
          icon: new Icon(_icons[2]),
          // text: 'Collections',
        ),
      ],
      // setup the controller
      controller: controller,
    );
  }

  // List<Widget> _getTabBar() {
  //   var _tabBar = new TabBar(
  //     indicator: UnderlineTabIndicator(
  //         borderSide: BorderSide(width: 1.0),
  //         insets: EdgeInsets.symmetric(horizontal: 16.0)),
  //     // indicatorSize: TabBarIndicatorSize.label,
  //     labelColor: Colors.white,
  //     unselectedLabelColor: Colors.grey[100],
  //     tabs: [
  //       new Tab(
  //         icon: new Icon(_icons[0]),
  //       ),
  //       new Tab(
  //         icon: new Icon(_icons[1]),
  //       ),
  //       new Tab(
  //         icon: new Icon(_icons[2]),
  //       ),
  //     ],
  //     controller: controller,
  //   );
  //   return [_tabBar];
  // }

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
    // return new DefaultTabController(
    //   // key: _scaffoldKey,
    //   length: _icons.length,
    //   child: new Scaffold(
    //     body: new NestedScrollView(
    //         headerSliverBuilder:
    //             (BuildContext context, bool innerBoxIsScrolled) {
    //           return <Widget>[
    //             new SliverAppBar(
    //               brightness: Brightness.dark,
    //               backgroundColor: Colors.black45,
    //               forceElevated: innerBoxIsScrolled,
    //               expandedHeight: 50.0,
    //               automaticallyImplyLeading: true,
    //               // pinned: true,
    //               // primary: true,
    //               title: new Text(title),
    //               flexibleSpace: const FlexibleSpaceBar(
    //                 centerTitle: false,
    //                 background: const Image(
    //                   colorBlendMode: BlendMode.multiply,
    //                   color: Colors.black38,
    //                   image: const AssetImage("images/tabbar.jpg"),
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //               bottom: getTabBar(),
    //               actions: <Widget>[
    //                 new IconButton(icon: Icon(Icons.search),
    //                 tooltip: 'Search',
    //                 onPressed: (){},),
    //                 new Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 5.0),
    //                 ),

    //               ],
    //             ),
    //           ];
    //         },
    //         body: WillPopScope(
    //           child: getTabBarView(<Widget>[
    //             new LatestPage(),
    //             new CuratedPage(),
    //             new PopularPage()
    //           ]),
    //           onWillPop: _onWillPop,
    //         )),
    //     drawer: NavigationDrawer(),
    //   ),
    // );

    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.black45,
          bottom: getTabBar(),
          title: new Text(title),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
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
