import 'package:flutter/material.dart';
import 'package:funsplash/api/unplash_api.dart';
import 'package:funsplash/utils/get_photo.dart';

class CuratedPage extends StatefulWidget {
  @override
  _CuratedPageState createState() => _CuratedPageState();
}

class _CuratedPageState extends State<CuratedPage> {
  final Key _curatedTabKey = const PageStorageKey('photos_curated');
  final _getPhotos = UnsplashApi().getCuratedPhotos();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: getNetworkPhoto(_curatedTabKey, _getPhotos));
  }
}
