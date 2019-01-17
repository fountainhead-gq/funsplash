import 'package:flutter/material.dart';
import 'package:funsplash/ui/share_page.dart';
import 'package:funsplash/ui/collection_page.dart';
import 'package:funsplash/ui/category_page.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return getDrawer();
  }

  Widget getDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                FlutterLogo(
                  size: 48.0,
                ),
                Text(
                  "Flutter Example",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  "flutterexample@gmail.com",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            decoration: BoxDecoration(color: Colors.black38),
          ),
          getNavigationItem(Icons.home, "Home", '/'),
          getNavigationItem(
              Icons.collections, "Collections", CollectionsPage.routName),
          getNavigationItem(
              Icons.category, "Category", CategoryPage.routName),
          Divider(),
          getNavigationItem(Icons.share, "Share", SharePage.routName),
          getNavigationItem(Icons.send, "Send", SharePage.routName),
        ],
      ),
    );
  }

  Widget getNavigationItem(IconData icon, String title, String routeName) {
    return new ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
        style: TextStyle(
          // fontFamily: Strings.fontRobotoBold,
          fontSize: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          // _title = title;
          Navigator.pop(context);
          // navigate to the route
          Navigator.of(context).pushNamed(routeName);
        });
      },
    );
  }
}
