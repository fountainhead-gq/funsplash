import 'package:flutter/material.dart';
import 'package:funsplash/utils/get_photo.dart';

class PopularPage extends StatefulWidget {
  @override
  PopularPageState createState() => new PopularPageState();
}

class PopularPageState extends State<PopularPage> {
  final Key _popularTabKey = const PageStorageKey('photos_popular');

  @override
  Widget build(BuildContext context) {
    return new GetNetworkPhoto(
      key: _popularTabKey,
    );
  }
}
