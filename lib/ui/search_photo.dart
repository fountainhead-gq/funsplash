import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:funsplash/api/unplash_api.dart';
import 'package:funsplash/model/categories.dart';
import 'package:funsplash/utils/colors.dart';
import 'package:funsplash/ui/search_photo_detail.dart';

class SearchResultPhotoPage extends StatefulWidget {
  final String searchContent;
  SearchResultPhotoPage(this.searchContent);
  @override
  _SearchResultPageState createState() => _SearchResultPageState(searchContent);
}

class _SearchResultPageState extends State<SearchResultPhotoPage>
    with TickerProviderStateMixin {
  final Key _searchTabKey = const PageStorageKey('photo_search');
  _SearchResultPageState(this.searchContent);
  String searchContent;
  int currentPageNumber = 1;

  List<PhotoResults> categoriesResults;
  ScrollController _scrollController;

  int pageNumber = 0;
  int loadBefore = 100;
  bool isLoading = false;
  double scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    categoriesResults = [];
    _loadPhotos();
    _scrollController =
        new ScrollController(initialScrollOffset: scrollPosition);
    _scrollController.addListener(() {
      var loadPoint = _scrollController.position.maxScrollExtent - loadBefore;
      if (_scrollController.position.pixels >= loadPoint) {
        _loadPhotos();
      }
      scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _loadPhotos() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      pageNumber += 1;
      var newPhotos;

      newPhotos = await UnsplashApi()
          .getPhotosBySearch(page: pageNumber, searchContext: searchContent);

      setState(() {
        categoriesResults.addAll(newPhotos.results);
        isLoading = false;
      });
    }
    return new Future.value(categoriesResults);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: ListView.builder(
          key: _searchTabKey,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: categoriesResults.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return new Container(
              height: 230.0,
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Stack(
                  alignment: const FractionalOffset(0.9, 0.1),
                  children: <Widget>[
                    Container(
                      color: CustomColor.colorFromHex(
                          categoriesResults[index].color),
                      child: new Parallax.inside(
                        mainAxisExtent: 150,
                        flipDirection: true,
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: categoriesResults[index].urls.regular,
                          fadeInDuration: Duration(milliseconds: 225),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Material(
                      type: MaterialType.transparency,
                      borderRadius: new BorderRadius.circular(10.0),
                      child: InkWell(
                        highlightColor: Colors.black45,
                        splashColor: Colors.black12,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SearchPhotoDetailPage(
                                      photo: categoriesResults[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  fit: StackFit.expand,
                ),
              ),
            );
          }),
    );
  }
}
