import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:funsplash/api/unplash_api.dart';
import 'package:funsplash/model/collection.dart';
import 'package:funsplash/utils/colors.dart';
import 'package:funsplash/ui/collections_detail.dart';

class CollectionsPage extends StatefulWidget {
  static const String routName = '/collections';
  @override
  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage>
    with TickerProviderStateMixin {
  final Key _allTabKey = const PageStorageKey('collections_all');
  int currentPageNumber = 1;



  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Collections'),
      ),
      body: new Container(
        child: FutureBuilder<List<Collection>>(
          future: UnsplashApi().getCollections().then((collections) =>
              collections
                  .where((collection) => collection?.coverPhoto != null)
                  .toList()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? CollectionsCard(
                    key: _allTabKey,
                    collections: snapshot.data,
                    pageNumber: currentPageNumber)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
      
    );
  }
}

class CollectionsCard extends StatefulWidget {
  final List<Collection> collections;
  final int pageNumber;

  CollectionsCard({Key key, @required this.collections, this.pageNumber})
      : super(key: key);

  @override
  _CollectionsCardState createState() => _CollectionsCardState();
}

class _CollectionsCardState extends State<CollectionsCard> {
  List<Collection> collections;
  int pageNumber;

  ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    collections = widget.collections;
    pageNumber = widget.pageNumber;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      if (_scrollController.position.maxScrollExtent >
              _scrollController.offset &&
          _scrollController.position.maxScrollExtent -
                  _scrollController.offset <=
              100) {
        if (!isLoadingMore) {
          isLoadingMore = true;
          pageNumber += 1;
          UnsplashApi().getCollections(page: pageNumber).then((newPhotos) {
            isLoadingMore = false;
            setState(() {
              collections.addAll(newPhotos);
            });
          });
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final Collection collection = collections[index];
          final List<Widget> overlayTexts = [];
          overlayTexts.add(Container(height: 5.0));
          overlayTexts.add(Text(
            collection.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
                color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600),
          ));
          overlayTexts.add(Container(height: 10.0));
          final String description = collection.user.name != null
              ? "${collection.totalPhotos} Photos | By ${collection.user.name}"
              : "${collection.totalPhotos} Photos";

          overlayTexts.add(Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(color: Colors.white, fontSize: 16),
          ));

          return Container(
            height: 230.0,
            child: Stack(
              children: <Widget>[
                Container(
                  color: CustomColor.colorFromHex(collection.coverPhoto.color),
                  child: new Parallax.inside(
                    mainAxisExtent: 150,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: collection.coverPhoto.urls.regular,
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
                  child: InkWell(
                    splashColor: Colors.white10,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CollectionsCardView(collection: collection),
                        ),
                      );
                    },
                  ),
                ),
              ],
              fit: StackFit.expand,
              // alignment: Alignment.topLeft,
            ),
          );
        },
      ),
    );
  }
}

class CollectionsCardView extends StatelessWidget {
  final Collection collection;

  CollectionsCardView({Key key, this.collection}) : super(key: key);

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
