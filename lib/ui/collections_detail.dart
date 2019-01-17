import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:funsplash/model/collection.dart';
import 'package:funsplash/model/photo.dart';
import 'package:funsplash/api/unplash_api.dart';
import 'package:funsplash/ui/photo_detail.dart';

class CollectionPhotosListView extends StatefulWidget {
  final Collection collection;
  CollectionPhotosListView({Key key, this.collection}) : super(key: key);

  @override
  _CollectionPhotosListViewState createState() =>
      _CollectionPhotosListViewState(collection);
}

class _CollectionPhotosListViewState extends State<CollectionPhotosListView> {
  List<Photo> items = [];
  ScrollController _scrollController;
  int page = 0;
  int loadBefore = 50;
  bool isLoading = false;
  double scrollPosition = 0.0;
  Collection collection;

  _CollectionPhotosListViewState([this.collection]) : super();

  @override
  void initState() {
    super.initState();
    items = [];
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
      page += 1;
      var newPhotos;

      if (collection == null) {
        newPhotos = await UnsplashApi().getCuratedPhotos();
      } else {
        newPhotos = await UnsplashApi().getByCollectionsPhotos(collection, page);
      }
      setState(() {
        items.addAll(newPhotos);
        isLoading = false;
      });
    }
    return new Future.value(items);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        child: new Container(
          child: GridView.count(
            padding: EdgeInsets.all(2.0),
            crossAxisCount: 1,
            controller: _scrollController,
            children: List.generate(items.length, (index) {
              if (index == items.length) {
                return new CircularProgressIndicator();
              }

              Photo photo = items[index];
              return CollectionPhotoItem(
                photo: photo,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new PhotoDetailPage(photo: photo),
                      ));
                },
              );
            }),
          ),
        ));
  }
}

class CollectionPhotoItem extends StatelessWidget {
  @required
  final Photo photo;

  @required
  final GestureTapCallback onTap;
  final EdgeInsetsGeometry padding;
  const CollectionPhotoItem({Key key, this.photo, this.onTap, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new GestureDetector(
            onTap: onTap,
            child: new ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              child: new FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: photo.urls.regular,
                fit: BoxFit.cover,
              ),
            )));
  }
}
