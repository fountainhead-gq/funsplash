import 'package:flutter/material.dart';
import 'package:funsplash/ui/search_photo.dart';

class SearchListPage extends StatefulWidget {
  final String searchContent;
  SearchListPage(this.searchContent);

  @override
  _SearchListPageState createState() => _SearchListPageState(searchContent);
}

class _SearchListPageState extends State<SearchListPage> {
  TextEditingController _searchController = new TextEditingController();
  FocusNode focusNode1 = new FocusNode();

  SearchResultPhotoPage _searchPhotoListPage;
  String searchContent;
  _SearchListPageState(this.searchContent);

  @override
  void initState() {
    super.initState();

    _searchController = new TextEditingController(text: searchContent);
    changeContent(_searchController.text);
  }

  void changeContent(String content) {
    focusNode1.unfocus();
    setState(() {
      _searchPhotoListPage = new SearchResultPhotoPage(content);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextField searchField = new TextField(
      autofocus: true,
      decoration: new InputDecoration(
        border: InputBorder.none,
        hintText: 'search',
      ),
      focusNode: focusNode1,
      controller: _searchController,
    );

    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.4,
        title: searchField,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
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
            child: new Text(_searchController.text +'test'),
              // child: new SearchHotPageUI(),
              )
          : _searchPhotoListPage,
//    body: Center(
//      child: SearchHotPageUI(),
//    ),
    );
  }
}
