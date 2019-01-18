import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:funsplash/model/collection.dart';
import 'package:funsplash/model/photo.dart';
import 'package:funsplash/utils/colors.dart';
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
        newPhotos =
            await UnsplashApi().getByCollectionsPhotos(collection, page);
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
      child: ListView.builder(
          // padding: EdgeInsets.all(2.0),
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: items.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return new Container(
              height: 250.0,
              child: AspectRatio(
                aspectRatio: 1.25,
                child: Stack(
                  alignment: const FractionalOffset(0.9, 0.1),
                  children: <Widget>[
                    Container(
                      color: CustomColor.colorFromHex(items[index].color),
                      child: new Parallax.inside(
                        mainAxisExtent: 150,
                        flipDirection: true,
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: items[index].urls.regular,
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
                                  PhotoDetailPage(photo: items[index]),
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

// class CollectionPhotoItem extends StatelessWidget {
//   @required
//   final Photo photo;

//   @required
//   final GestureTapCallback onTap;
//   final EdgeInsetsGeometry padding;
//   const CollectionPhotoItem({Key key, this.photo, this.onTap, this.padding})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//         child: new GestureDetector(
//             onTap: onTap,
//             child: new ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(3.0)),
//               child: new FadeInImage.memoryNetwork(
//                 placeholder: kTransparentImage,
//                 image: photo.urls.regular,
//                 fit: BoxFit.cover,
//               ),
//             )));
//   }
// }
