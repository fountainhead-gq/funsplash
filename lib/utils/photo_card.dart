import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:funsplash/model/photo.dart';
import 'package:funsplash/utils/custom_localizations.dart';

Widget photoDataCard(BuildContext context, Photo photo) {
  int likes, views, downloads;

  final String downloadsTimes =
      FunsplashLocalizations.of(context).trans('downloads');
  final String viewsTimes = FunsplashLocalizations.of(context).trans('views');
  final String likesTimes = FunsplashLocalizations.of(context).trans('likes');

  if (photo.likes == null) {
    likes = 0;
  } else {
    likes = photo.likes;
  }
  if (photo.downloads == null) {
    downloads = 0;
  } else {
    downloads = photo.downloads;
  }
  if (photo.views == null) {
    views = 0;
  } else {
    views = photo.views;
  }

  var card = SizedBox(
    height: 200.0,
    child: Card(
      color: Theme.of(context).copyWith().primaryColor,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.cloud_download,
              color: Colors.white54,
            ),
            title: Text(downloads.toString() + downloadsTimes,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white70)),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.white54,
            ),
            title: Text(likes.toString() + likesTimes,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white70)),
          ),
          ListTile(
            leading: Icon(
              Icons.remove_red_eye,
              color: Colors.white54,
            ),
            title: Text(views.toString() + viewsTimes,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white70)),
          ),
        ],
      ),
    ),
  );
  return card;
}

Widget createDownloadCard(BuildContext context, var photo) {
  String fullPhotoUrl = photo.urls.full;
  String regularPhotoUrl = photo.urls.regular;
  final String hdImage = FunsplashLocalizations.of(context).trans('hd_image');
  final String hdImageDesc =
      FunsplashLocalizations.of(context).trans('hd_image_qd');
  final String s4kImage = FunsplashLocalizations.of(context).trans('4k_image');
  final String s4kImageDesc =
      FunsplashLocalizations.of(context).trans('4k_image_qd');
  var card = SizedBox(
    height: 200.0,
    child: Card(
      color: Theme.of(context).copyWith().primaryColor,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              _downloadNetworkImage(regularPhotoUrl);
            },
            leading: Icon(
              Icons.hd,
              color: Colors.white54,
            ),
            title: Text(hdImage,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white70)),
            subtitle: Text(hdImageDesc,
                style: TextStyle(fontSize: 16, color: Colors.white70)),
          ),
          Divider(),
          ListTile(
            onTap: () {
              _downloadNetworkImage(fullPhotoUrl);
            },
            leading: Icon(
              Icons.four_k,
              color: Colors.white54,
            ),
            title: Text(s4kImage,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white70)),
            subtitle: Text(
              photo.width.toString() +
                  ' x ' +
                  photo.height.toString() +
                  s4kImageDesc,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ),
        ],
      ),
    ),
  );
  return card;
}

void _downloadNetworkImage(String url) async {
  var response = await http.get(url);

  debugPrint(response.statusCode.toString());

  var filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
  var savedFile = File.fromUri(Uri.file(filePath));
}
