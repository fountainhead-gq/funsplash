import 'package:flutter/material.dart';
import 'package:funsplash/api/unplash_api.dart';
import 'package:funsplash/utils/get_photo.dart';

class LatestPage extends StatefulWidget {
  @override
  _LatestPageState createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage> {
  final Key _latestTabKey = const PageStorageKey('photos_latest');
  final _getPhotos = UnsplashApi().getLatestPhotos();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: getNetworkPhoto(_latestTabKey, _getPhotos));
  }
}
