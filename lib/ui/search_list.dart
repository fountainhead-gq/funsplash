import 'package:flutter/material.dart';
import 'package:funsplash/ui/search_photo.dart';
import 'package:funsplash/ui/search_collection.dart';
import 'package:funsplash/utils/custom_localizations.dart';

class SearchListPage extends StatefulWidget {
  final String searchContent;
  SearchListPage(this.searchContent);

  @override
  _SearchListPageState createState() => _SearchListPageState(searchContent);
}

class _SearchListPageState extends State<SearchListPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  SearchResultPhotoPage _searchPhotoListPage;
  SearchResultCollectionPage _searchCollectionListPage;

  _SearchListPageState(this.searchContent);
  String searchContent;
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
    _searchController = new TextEditingController(text: searchContent);
    changeContent(_searchController.text);
  }

  @override
  void dispose() {
    controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void changeContent(String content) {
    _focusNode.unfocus();
    setState(() {
      _searchPhotoListPage = new SearchResultPhotoPage(content);
      _searchCollectionListPage = new SearchResultCollectionPage(content);
    });
  }

  TabBar getTabBar(tabTitle) {
    return new TabBar(
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 1.0),
          insets: EdgeInsets.symmetric(horizontal: 16.0)),
      indicatorColor: Colors.orangeAccent,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: <Widget>[
        new Container(
          height: 35,
          child: new Tab(
            text: tabTitle[0].toString(),
          ),
        ),
        new Container(
          height: 35,
          child: new Tab(
            text: tabTitle[1].toString(),
          ),
        ),
      ],
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return new TabBarView(
      children: tabs,
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String searchTitle =
        FunsplashLocalizations.of(context).trans('search');
    final String collectionsTab =
        FunsplashLocalizations.of(context).trans('collections');
    final String photosTab = FunsplashLocalizations.of(context).trans('photos');
    final tabTitle = [photosTab, collectionsTab];

    TextField searchField = new TextField(
      autofocus: true,
      decoration: new InputDecoration(
        border: InputBorder.none,
        hintText: searchTitle,
        fillColor: Colors.white54,
      ),
      focusNode: _focusNode,
      controller: _searchController,
    );

    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.4,
        title: searchField,
        bottom: new PreferredSize(
          preferredSize: new Size(30, 30),
          child: new Container(
            child: getTabBar(tabTitle),
          ),
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              tooltip: searchTitle,
              onPressed: () {
                changeContent(_searchController.text);
              }),
          // new IconButton(
          //     icon: new Icon(Icons.close),
          //     onPressed: () {
          //       setState(() {
          //         _searchController.clear();
          //       });
          //     }),
        ],
      ),
      body: (_searchController.text == null || _searchController.text.isEmpty)
          ? new Center(
              child: new Text(_searchController.text),
            )
          : getTabBarView(<Widget>[
              _searchPhotoListPage,
              _searchCollectionListPage,
            ]),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.search),
        backgroundColor: Theme.of(context).copyWith().primaryColor,
        onPressed: () {
          changeContent(_searchController.text);
        },
      ),
    );
  }
}
