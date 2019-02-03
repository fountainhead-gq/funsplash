import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper/wallpaper.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    // String result;
    final String dataTitle = FunsplashLocalizations.of(context).trans('data');

    final String downloadTitle =
        FunsplashLocalizations.of(context).trans('download');
    final String wallpaper =
        FunsplashLocalizations.of(context).trans('wallpaper');

    final String homeScreen =
        FunsplashLocalizations.of(context).trans('home_screen');
    final String lockScreen =
        FunsplashLocalizations.of(context).trans('lock_screen');
    final String bothScreen =
        FunsplashLocalizations.of(context).trans('both_screen');

    final String homeScreenDesc =
        FunsplashLocalizations.of(context).trans('home_screen_desc');
    final String lockScreenDesc =
        FunsplashLocalizations.of(context).trans('lock_screen_desc');
    final String bothScreenDesc =
        FunsplashLocalizations.of(context).trans('both_screen_desc');

    final String downloadsTimes =
        FunsplashLocalizations.of(context).trans('downloads');
    final String viewsTimes = FunsplashLocalizations.of(context).trans('views');
    final String likesTimes = FunsplashLocalizations.of(context).trans('likes');
    List viewAndLikes = [downloadsTimes, viewsTimes, likesTimes];

    final String hdImage = FunsplashLocalizations.of(context).trans('hd_image');
    final String hdImageDesc =
        FunsplashLocalizations.of(context).trans('hd_image_qd');
    final String s4kImage =
        FunsplashLocalizations.of(context).trans('4k_image');
    final String s4kImageDesc =
        FunsplashLocalizations.of(context).trans('4k_image_qd');
    List hd4kImage = [hdImage, hdImageDesc, s4kImage, s4kImageDesc];

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
                      child: photoDataCard(
                          context, photo, viewAndLikes, primaryColor),
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
                          context, photo, hd4kImage, primaryColor),
                    ),
                  );
                });
          },
        )));

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: wallpaper,
      labelHasShadow: false,
      labelColor: Colors.white70,
      labelBackgroundColor: Color.fromARGB(20, 255, 255, 255),
      currentButton: FloatingActionButton(
        heroTag: wallpaper,
        backgroundColor: primaryColor,
        mini: true,
        child: Icon(Icons.wallpaper),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  child: new Center(
                    child: new SizedBox(
                      height: 230.0,
                      child: Card(
                        color: primaryColor,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () async {
                                String res;
                                res =
                                    await Wallpaper.HomeScreen(photo.urls.full);
                                if (!mounted) return;
                                setState(() {
                                  // result = res.toString();
                                  print(res.toString());
                                  Fluttertoast.showToast(
                                      msg: res.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      textColor: primaryColor,
                                      fontSize: 16.0);
                                });
                              },
                              leading: Icon(
                                Icons.home,
                                color: Colors.white54,
                              ),
                              title: Text(homeScreen,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white70)),
                              subtitle: Text(
                                homeScreenDesc,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white54),
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                String res;
                                res =
                                    await Wallpaper.LockScreen(photo.urls.full);
                                if (!mounted) return;
                                setState(() {
                                  // result = res.toString();
                                  print(res.toString());
                                  Fluttertoast.showToast(
                                      msg: res.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      textColor: primaryColor,
                                      fontSize: 16.0);
                                });
                              },
                              leading: Icon(
                                Icons.lock_outline,
                                color: Colors.white54,
                              ),
                              title: Text(lockScreen,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white70)),
                              subtitle: Text(
                                lockScreenDesc,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white54),
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                String res;
                                res = await Wallpaper.Both(photo.urls.full);
                                if (!mounted) return;
                                setState(() {
                                  // result = res.toString();
                                  print(res.toString());
                                  Fluttertoast.showToast(
                                      msg: res.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      textColor: Theme.of(context).primaryColor,
                                      fontSize: 16.0);
                                });
                              },
                              leading: Icon(
                                Icons.smartphone,
                                color: Colors.white54,
                              ),
                              title: Text(bothScreen,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white70)),
                              subtitle: Text(
                                bothScreenDesc,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    ));

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
