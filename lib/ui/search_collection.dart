import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:funsplash/api/unplash_api.dart';
import 'package:funsplash/utils/colors.dart';
import 'package:funsplash/model/collection.dart';
import 'package:funsplash/ui/collections_detail.dart';

class SearchResultCollectionPage extends StatefulWidget {
  final String searchContent;
  SearchResultCollectionPage(this.searchContent);
  @override
  _SearchResultCollectionPage createState() =>
      _SearchResultCollectionPage(searchContent);
}

class _SearchResultCollectionPage extends State<SearchResultCollectionPage>
    with TickerProviderStateMixin {
  final Key _searchTabKey = const PageStorageKey('collection_search');
  _SearchResultCollectionPage(this.searchContent);
  String searchContent;
  int currentPageNumber = 1;

  List<Collection> collectionsResults;
  ScrollController _scrollController;

  int pageNumber = 0;
  int loadBefore = 100;
  bool isLoading = false;
  double scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    collectionsResults = [];
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

      newPhotos = await UnsplashApi().getCollectionsBySearch(
          page: pageNumber, searchContext: searchContent);

      setState(() {
        collectionsResults.addAll(newPhotos.results);
        isLoading = false;
      });
    }
    return new Future.value(collectionsResults);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: ListView.builder(
          key: _searchTabKey,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: collectionsResults.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final List<Widget> overlayTexts = [];
            overlayTexts.add(Container(height: 5.0));
            overlayTexts.add(Text(
              collectionsResults[index].title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w600),
            ));
            overlayTexts.add(Container(height: 10.0));
            final String description = collectionsResults[index].user.name !=
                    null
                ? "${collectionsResults[index].totalPhotos} Photos | By ${collectionsResults[index].user.name}"
                : "${collectionsResults[index].totalPhotos} Photos";

            overlayTexts.add(Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(color: Colors.white, fontSize: 16),
            ));

            return new Container(
              height: 230.0,
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Stack(
                  alignment: const FractionalOffset(0.9, 0.1),
                  children: <Widget>[
                    Container(
                      color: CustomColor.colorFromHex(
                          collectionsResults[index].coverPhoto.color),
                      child: new Parallax.inside(
                        mainAxisExtent: 150,
                        flipDirection: true,
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image:
                              collectionsResults[index].coverPhoto.urls.regular,
                          fadeInDuration: Duration(milliseconds: 225),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black45,
                            Colors.black26,
                            Colors.black12,
                            Colors.transparent
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: overlayTexts,
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
                                  GeneratedCollectionsCard(
                                      collection: collectionsResults[index]),
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

class GeneratedCollectionsCard extends StatelessWidget {
  final Collection collection;

  GeneratedCollectionsCard({Key key, this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          collection.title,
        ),
      ),
      body: CollectionPhotosListView(collection: collection),
    );
  }
}
