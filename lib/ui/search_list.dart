import 'package:flutter/material.dart';
import 'package:funsplash/ui/search_photo.dart';

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
  SearchResultPhotoPage _searchCollectionListPage;
  SearchResultPhotoPage _searchUserListPage;
  String searchContent;
  _SearchListPageState(this.searchContent);

  final _tabTitle = ['photo', 'collection', 'user'];
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: _tabTitle.length, vsync: this);
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
      _searchCollectionListPage = new SearchResultPhotoPage(content);
      _searchUserListPage = new SearchResultPhotoPage(content);
    });
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
          text: _tabTitle[0].toString(),
        ),
        new Tab(
          text: _tabTitle[1].toString(),
        ),
        new Tab(
          text: _tabTitle[2].toString(),
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
    TextField searchField = new TextField(
      autofocus: true,
      decoration: new InputDecoration(
        border: InputBorder.none,
        hintText: 'search',
      ),
      focusNode: _focusNode,
      controller: _searchController,
    );

    return new Scaffold(
        appBar: new AppBar(
          elevation: 0.4,
          title: searchField,
          bottom: getTabBar(),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.search),
                tooltip: 'search',
                onPressed: () {
                  changeContent(_searchController.text);
                }),
            new IconButton(
                icon: new Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                  });
                }),
          ],
        ),
        body: (_searchController.text == null || _searchController.text.isEmpty)
            ? new Center(
                child: new Text(_searchController.text),
              )
            : getTabBarView(<Widget>[
                _searchPhotoListPage,
                _searchCollectionListPage,
                _searchUserListPage
              ])
        // : _searchPhotoListPage,
        );
  }
}
