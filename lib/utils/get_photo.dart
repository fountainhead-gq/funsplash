import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:funsplash/model/photo.dart';
import 'package:funsplash/ui/photo_detail.dart';
import 'package:funsplash/utils/colors.dart';
import 'package:funsplash/api/unplash_api.dart';
import 'package:funsplash/utils/custom_localizations.dart';

class GetNetworkPhoto extends StatefulWidget {
  GetNetworkPhoto({Key key}) : super(key: key);

  @override
  _GetNetworkPhotoState createState() => _GetNetworkPhotoState(key);
}

class _GetNetworkPhotoState extends State<GetNetworkPhoto> {
  Key key;
  int currentPageNumber = 1;
  _GetNetworkPhotoState(this.key);
  Future<List<Photo>> getPhotos;

  @override
  void initState() {
    key = widget.key;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (key.toString().contains('photos_latest')) {
      getPhotos = UnsplashApi().getLatestPhotos();
    } else if (key.toString().contains('photos_curated')) {
      getPhotos = UnsplashApi().getCuratedPhotos();
    } else if (key.toString().contains('photos_popular')) {
      getPhotos = UnsplashApi().getPopularPhotos();
    }

    return new Scaffold(
      body: new Container(
        child: new FutureBuilder<List<Photo>>(
            future: getPhotos,
            builder: (BuildContext context, snapshot) {
              try {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  // return new Text('Press button to start');
                  case ConnectionState.waiting:
                  // return new Text('loading...');
                  default:
                    if (snapshot.hasError)
                      return new Container(
                        child: new Center(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.cloud_off),
                              Text(
                                FunsplashLocalizations.of(context)
                                    .trans('reload'),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      );
                    else
                      return snapshot.hasData
                          ? PhotosCard(
                              key: key,
                              photos: snapshot.data,
                              pageNumber: currentPageNumber,
                            )
                          : Center(child: CircularProgressIndicator());
                }
              } catch (e) {
                return new Text(
                  "Error Fetching Data",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                );
              }
            }),
      ),
    );
  }
}

class PhotosCard extends StatefulWidget {
  final List<Photo> photos;
  final int pageNumber;

  PhotosCard({Key key, @required this.photos, this.pageNumber})
      : super(key: key);

  @override
  _PhotosCardState createState() => _PhotosCardState(photos);
}

class _PhotosCardState extends State<PhotosCard> {
  _PhotosCardState(this.photos);
  List<Photo> photos;
  int pageNumber;
  Key key;

  ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    photos = widget.photos;
    pageNumber = widget.pageNumber;
    key = widget.key;
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
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
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
    );
  }
}
