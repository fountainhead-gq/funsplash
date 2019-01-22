import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:funsplash/model/categories.dart';
import 'package:funsplash/utils/create_card.dart';
import 'package:funsplash/utils/colors.dart';

class SearchPhotoDetailPage extends StatefulWidget {
  final PhotoResults photo;
  SearchPhotoDetailPage({Key key, this.photo}) : super(key: key);

  @override
  _SearchPhotoDetailPageState createState() =>
      _SearchPhotoDetailPageState(photo);
}

class _SearchPhotoDetailPageState extends State<SearchPhotoDetailPage> {
  PhotoResults photo;
  _SearchPhotoDetailPageState(this.photo);
  final Key scaffoldKey = const PageStorageKey('search_photo_detail');

  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "data",
        labelHasShadow: false,
        labelColor: Colors.white70,
        labelBackgroundColor: Color.fromARGB(20, 255, 255, 255),
        currentButton: FloatingActionButton(
          heroTag: "data",
          backgroundColor: Colors.amber[200],
          mini: true,
          child: Icon(Icons.timeline),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    child: new Center(
                      child: createDataCard(context, photo),
                    ),
                  );
                });
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "info",
        labelHasShadow: false,
        labelColor: Colors.white70,
        labelBackgroundColor: Color.fromARGB(20, 255, 255, 255),
        currentButton: FloatingActionButton(
          heroTag: "info",
          backgroundColor: Colors.amber[200],
          mini: true,
          child: Icon(Icons.info),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    child: new Center(
                      child: createDataCard(context, photo),
                    ),
                  );
                });
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "download",
        labelHasShadow: false,
        labelColor: Colors.white70,
        labelBackgroundColor: Color.fromARGB(20, 255, 255, 255),
        currentButton: FloatingActionButton(
          heroTag: "download",
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
                  fit: BoxFit.fitHeight,
                  // fit: BoxFit.cover,
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
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.15),
          parentButtonBackground: Colors.amberAccent,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.keyboard_arrow_up),
          childButtons: childButtons),
    );
  }

  List<Widget> _createListContent(BuildContext context, PhotoResults photo) {
    final profileImage = photo.user.profileImage;
    final photoUser = "Photo by ${photo.user.name}";
    final List<Widget> contents = [];
    contents.add(Container(
      decoration: BoxDecoration(color: Colors.black),
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
