import 'package:flutter/material.dart';
import 'package:funsplash/utils/get_photo.dart';

class LatestPage extends StatefulWidget {
  @override
  _LatestPageState createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage> {
  Key _latestTabKey = const PageStorageKey('photos_latest');

  @override
  Widget build(BuildContext context) {
    return new GetNetworkPhoto(
      key: _latestTabKey,
    );
  }
}
