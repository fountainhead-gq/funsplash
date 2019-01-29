import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:funsplash/model/photo.dart';
import 'package:funsplash/utils/photo_card.dart';
import 'package:funsplash/utils/colors.dart';

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
                      child: photoDataCard(context, photo),
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
                      child: photoDataCard(context, photo),
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

  // List<Widget> _createListContent(BuildContext context) {
  //   final textTheme = Theme.of(context).textTheme;
  //   final profileImage = photo.user.profileImage;
  //   final description = photo.description ?? "Photo by ${photo.user.name}";
  //   final photoUser = "Photo by ${photo.user.name}";
  //   final List<Widget> contents = [];
  //   contents.add(Container(
  //     decoration: BoxDecoration(color: Colors.black),
  //     // padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
  //     child: ListTile(
  //       leading: CircleAvatar(
  //         backgroundImage: NetworkImage(profileImage.medium),
  //         radius: 20.0,
  //       ),
  //       contentPadding: EdgeInsets.only(left: 5.0),
  //       title: Text(photoUser),
  //     ),
  //   ));
  //   // contents.add(Container(height: 1.0));
  //   // if (photo.user.profileImage != null) {
  //   //   contents.add(ListTile(
  //   //     leading: CircleAvatar(
  //   //       backgroundImage: NetworkImage(profileImage.small),
  //   //       radius: 20.0,
  //   //     ),
  //   //     title: Text(photo.user.name),
  //   //   ));
  //   // } else {
  //   //   contents.add(ListTile(
  //   //     leading: Icon(Icons.person, color: Colors.black54),
  //   //     title: Text(photo.user.name),
  //   //   ));
  //   // }
  //   // if (photo.user.bio != null) {
  //   //   contents.add(Padding(
  //   //     padding: EdgeInsets.only(left: 72.0, right: 16.0),
  //   //     child: Text(photo.user.bio,
  //   //         style: textTheme.body1.copyWith(color: Colors.black54)),
  //   //   ));
  //   // }
  //   // contents.add(Container(height: 16.0));
  //   // contents.add(Divider(height: 0.0, indent: 72.0));
  //   // contents.add(Container(height: 8.0));
  //   // contents.add(ListTile(
  //   //   leading: Icon(Icons.photo_size_select_large, color: Colors.black54),
  //   //   title: Text("${photo.width}px x ${photo.height}px"),
  //   // ));
  //   // contents.add(ListTile(
  //   //   leading: Icon(Icons.access_time, color: Colors.black54),
  //   //   title: Text(
  //   //       DateFormat('yyyy/MM/dd HH:mm').format(photo.createdAt.toLocal())),
  //   // ));
  //   // contents.add(Container(height: 8.0));
  //   return contents;
  // }
}
