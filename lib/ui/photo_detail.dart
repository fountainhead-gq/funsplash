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
    // final String infoTitle = FunsplashLocalizations.of(context).trans('info');
    final String downloadTitle =
        FunsplashLocalizations.of(context).trans('download');
    final primaryColor = Theme.of(context).copyWith().primaryColor;
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: dataTitle,
        labelHasShadow: false,
        labelColor: Colors.white70,
        labelBackgroundColor: Color.fromARGB(20, 255, 255, 255),
        currentButton: FloatingActionButton(
          heroTag: dataTitle,
          backgroundColor: primaryColor,
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
        labelText: downloadTitle,
        labelHasShadow: false,
        labelColor: Colors.white70,
        labelBackgroundColor: Color.fromARGB(20, 255, 255, 255),
        currentButton: FloatingActionButton(
          heroTag: downloadTitle,
          backgroundColor: primaryColor,
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

    // childButtons.add(UnicornButton(
    //     hasLabel: true,
    //     labelText: infoTitle,
    //     labelHasShadow: false,
    //     labelColor: Colors.white70,
    //     labelBackgroundColor: Color.fromARGB(20, 255, 255, 255),
    //     currentButton: FloatingActionButton(
    //       heroTag: infoTitle,
    //       backgroundColor: primaryColor,
    //       mini: true,
    //       child: Icon(Icons.info),
    //       onPressed: () {
    //         showDialog(
    //             context: context,
    //             builder: (context) {
    //               return Container(
    //                 child: new Center(
    //                   child: photoDataCard(context, photo),
    //                 ),
    //               );
    //             });
    //       },
    //     )));

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
              delegate: SliverChildListDelegate(
                  _createListContent(context, photo, primaryColor)),
            ),
          ),
        ],
      ),
      floatingActionButton: UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.25),
          parentButtonBackground: primaryColor,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.keyboard_arrow_up),
          childButtons: childButtons),
    );
  }

  List<Widget> _createListContent(
      BuildContext context, Photo photo, primaryColor) {
    final profileImage = photo.user.profileImage;
    final photoUser = "Photo by ${photo.user.name}";
    String views, likes, description;
    if (photo.views == null) {
      views = '0';
    } else {
      views = photo.views.toString();
    }

    if (photo.likes == null) {
      likes = '0';
    } else {
      likes = photo.likes.toString();
    }

    if (photo.description == null) {
      description = '---';
    } else {
      description = photo.description.toString();
    }

    final List<Widget> contents = [];
    contents.add(Container(
      decoration: BoxDecoration(color: primaryColor),
      // padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profileImage.medium),
          radius: 20.0,
        ),
        contentPadding: EdgeInsets.only(left: 5.0),
        title: Text(
          photoUser,
          style: new TextStyle(color: Colors.white54),
        ),
      ),
    ));
    contents.add(Container(
      decoration: BoxDecoration(color: primaryColor),
      child: new ListTile(
        leading: new Icon(
          Icons.straighten,
          color: Colors.white70,
        ),
        title: new Text(
          photo.width.toString() + " x " + photo.height.toString(),
          style: new TextStyle(color: Colors.white70),
        ),
      ),
    ));

    contents.add(Container(
      decoration: BoxDecoration(color: primaryColor),
      child: new ListTile(
        leading: new Icon(
          Icons.date_range,
          color: Colors.white70,
        ),
        title: new Text(
          photo.createdAt.year.toString() +
              '-' +
              photo.createdAt.month.toString() +
              '-' +
              photo.createdAt.day.toString(),
          style: new TextStyle(color: Colors.white70),
        ),
      ),
    ));
    contents.add(Container(
      decoration: BoxDecoration(color: primaryColor),
      child: new ListTile(
        leading: new Icon(
          Icons.person_pin,
          color: Colors.white70,
        ),
        title: new Text(
          photo.user.name,
          style: new TextStyle(color: Colors.white70),
        ),
      ),
    ));
    contents.add(Container(
      decoration: BoxDecoration(color: primaryColor),
      child: new ListTile(
        leading: new Icon(
          Icons.color_lens,
          color: Colors.white70,
        ),
        title: new Text(
          photo.color.toString(),
          style: new TextStyle(color: Colors.white70),
        ),
      ),
    ));
    contents.add(Container(
      decoration: BoxDecoration(color: primaryColor),
      child: new ListTile(
        leading: new Icon(
          Icons.description,
          color: Colors.white70,
        ),
        title: new Text(
          description,
          style: new TextStyle(color: Colors.white70),
        ),
      ),
    ));
    contents.add(Container(
      decoration: BoxDecoration(color: primaryColor),
      child: new ListTile(
        leading: new Icon(
          Icons.remove_red_eye,
          color: Colors.white70,
        ),
        title: new Text(
          views,
          style: new TextStyle(color: Colors.white70),
        ),
      ),
    ));
    contents.add(Container(
      decoration: BoxDecoration(color: primaryColor),
      child: new ListTile(
        leading: new Icon(
          Icons.favorite,
          color: Colors.white70,
        ),
        title: new Text(
          likes,
          style: new TextStyle(color: Colors.white70),
        ),
      ),
    ));
    return contents;
  }
}
