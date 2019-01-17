import 'package:flutter/material.dart';
import 'package:funsplash/api/unplash_api.dart';
import 'package:funsplash/utils/get_photo.dart';

class PopularPage extends StatefulWidget {
  @override
  PopularPageState createState() => new PopularPageState();
}

class PopularPageState extends State<PopularPage> {
  final Key _popularTabKey = const PageStorageKey('photos_popular');
  // int currentPageNumber = 1;
  final _getPhotos = UnsplashApi().getPopularPhotos();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: getNetworkPhoto(_popularTabKey, _getPhotos));
  }
}
