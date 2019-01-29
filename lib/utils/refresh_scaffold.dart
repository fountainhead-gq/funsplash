import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:funsplash/model/photo.dart';
import 'package:funsplash/ui/photo_detail.dart';
import 'package:funsplash/utils/colors.dart';
import 'package:funsplash/api/unplash_api.dart';

class ResfreshScaffold extends StatefulWidget {
  ResfreshScaffold({
    Key key,
  }) : super(key: key);

  @override
  _ResfreshScaffoldState createState() => _ResfreshScaffoldState();
}

class _ResfreshScaffoldState extends State<ResfreshScaffold> {
  List<Photo> photos = new List();

  ScrollController _scrollController;
  bool isLoadingMore = false;
  bool isShowFloatBtn = false;
  int pageNumber = 1;
  double scrollPosition = 0.0;
  int loadBefore = 50;
  Key key;

  @override
  void initState() {
    super.initState();
    photos = [];
    pageNumber = 1;
    key = widget.key;
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
    if (!isLoadingMore) {
      isLoadingMore = true;
      pageNumber += 1;

      if (key.toString().contains('photos_popular')) {
        UnsplashApi().getPopularPhotos(page: pageNumber).then((newPhotos) {
          isLoadingMore = false;
          setState(() {
            photos.addAll(newPhotos);
          });
        });
      } else if (key.toString().contains('photos_latest')) {
        UnsplashApi().getLatestPhotos(page: pageNumber).then((newPhotos) {
          isLoadingMore = false;
          setState(() {
            photos.addAll(newPhotos);
          });
        });
      } else if (key.toString().contains('photos_curated')) {
        UnsplashApi().getCuratedPhotos(page: pageNumber).then((newPhotos) {
          isLoadingMore = false;
          setState(() {
            photos.addAll(newPhotos);
          });
        });
      }
    }
  }

  Widget buildFloatingActionButton() {
    if (_scrollController == null || _scrollController.offset < 480) {
      return null;
    }

    return new FloatingActionButton(
        heroTag: '',
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.keyboard_arrow_up,
        ),
        onPressed: () {
          _scrollController.animateTo(0.0,
              duration: new Duration(milliseconds: 300), curve: Curves.linear);
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new ListView.builder(
            controller: _scrollController,
            itemCount: photos.length,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
                  height: 230,
                  child: AspectRatio(
                    // aspectRatio: photos[index].width / photos[index].height,
                    aspectRatio: 1.5,
                    child: Stack(
                      alignment: const FractionalOffset(0.9, 0.1),
                      children: <Widget>[
                        Container(
                          color: CustomColor.colorFromHex(photos[index].color),
                          child: new Parallax.inside(
                            mainAxisExtent: 150,
                            flipDirection: true,
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: photos[index].urls.regular,
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
                                      PhotoDetailPage(photo: photos[index]),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      fit: StackFit.expand,
                    ),
                  ),
                )),
      ),
    );
  }
}
