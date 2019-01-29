import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:funsplash/model/photo.dart';
import 'package:funsplash/utils/photo_card.dart';
import 'package:funsplash/utils/colors.dart';
import 'package:funsplash/utils/custom_localizations.dart';

class PhotoDetailPage extends StatefulWidget {
  final Photo photo;
  PhotoDetailPage({Key key, this.photo}) : super(key: key);

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState(photo);
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  _PhotoDetailPageState(this.photo);
  final Photo photo;

  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final String dataTitle = FunsplashLocalizations.of(context).trans('data');
    final String infoTitle = FunsplashLocalizations.of(context).trans('info');
    final String downloadTitle =
        FunsplashLocalizations.of(context).trans('download');
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: dataTitle,
        labelHasShadow: false,
        labelColor: Colors.white70,
        labelBackgroundColor: Color.fromARGB(20, 255, 255, 255),
        currentButton: FloatingActionButton(
          heroTag: dataTitle,
          backgroundColor: Colors.amber[200],
          mini: true,
          child: Icon(Icons.timeline),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    child: new Center(
                      child: photoDataCard(context, photo),
                    ),
                  );
                });
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: infoTitle,
        labelHasShadow: false,
        labelColor: Colors.white70,
        labelBackgroundColor: Color.fromARGB(20, 255, 255, 255),
        currentButton: FloatingActionButton(
          heroTag: infoTitle,
          backgroundColor: Colors.amber[200],
          mini: true,
          child: Icon(Icons.info),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    child: new Center(
                      child: photoDataCard(context, photo),
                    ),
                  );
                });
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: downloadTitle,
        labelHasShadow: false,
        labelColor: Colors.white70,
        labelBackgroundColor: Color.fromARGB(20, 255, 255, 255),
        currentButton: FloatingActionButton(
          heroTag: downloadTitle,
          backgroundColor: Colors.amber[200],
          mini: true,
          child: Icon(Icons.cloud_download),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    child: new Center(
                      child: createDownloadCard(
                        context,
                        photo,
                      ),
                    ),
                  );
                });
          },
        )));

    return new Scaffold(
      key: scaffoldKey,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        primary: true,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight:
                MediaQuery.of(context).size.width / photo.width * photo.height,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: CustomColor.colorFromHex(photo.color),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: photo.urls.regular,
                  fadeInDuration: Duration(milliseconds: 225),
                  // fit: BoxFit.fitHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate:
                  SliverChildListDelegate(_createListContent(context, photo)),
            ),
          ),
        ],
      ),
      floatingActionButton: UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.25),
          parentButtonBackground: Colors.amber[300],
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.keyboard_arrow_up),
          childButtons: childButtons),
    );
  }

  List<Widget> _createListContent(BuildContext context, Photo photo) {
    final profileImage = photo.user.profileImage;
    final photoUser = "Photo by ${photo.user.name}";
    final List<Widget> contents = [];
    contents.add(Container(
      decoration: BoxDecoration(color: Colors.black),
      // padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profileImage.medium),
          radius: 20.0,
        ),
        contentPadding: EdgeInsets.only(left: 5.0),
        title: Text(photoUser),
      ),
    ));
    return contents;
  }
}
