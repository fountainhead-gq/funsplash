import 'package:flutter/material.dart';
import 'package:funsplash/ui/home_page.dart';
import 'package:funsplash/ui/share_page.dart';
import 'package:funsplash/ui/collection_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'funsplash';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        // primarySwatch: Colors.white,
        // primaryColor: Colors.white,
        // fontFamily: 'Roboto Mono',
        accentColor: Colors.white,
        accentIconTheme: new IconThemeData(color: Colors.black87),
        textSelectionHandleColor: Colors.black87,
      ),
      home: HomePage(title: title),
      routes: <String, WidgetBuilder>{
        SharePage.routName: (BuildContext context) => new SharePage(),
        CollectionsPage.routName: (BuildContext context) =>
            new CollectionsPage(),
      },
    );
  }
}
