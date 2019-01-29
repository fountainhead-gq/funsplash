import 'package:flutter/material.dart';
import 'package:funsplash/utils/get_photo.dart';

class CuratedPage extends StatefulWidget {
  @override
  _CuratedPageState createState() => _CuratedPageState();
}

class _CuratedPageState extends State<CuratedPage> {
  final Key _curatedTabKey = const PageStorageKey('photos_curated');

  @override
  Widget build(BuildContext context) {
    return new GetNetworkPhoto(
      key: _curatedTabKey,
    );
  }
}
