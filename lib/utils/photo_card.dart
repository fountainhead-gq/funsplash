import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:funsplash/model/photo.dart';
import 'package:funsplash/utils/custom_localizations.dart';

Widget photoDataCard(
    BuildContext context, Photo photo, List viewAndLikes, Color primaryColor) {
  int likes, views, downloads;

  final String downloadsTimes = viewAndLikes[0];
  final String viewsTimes = viewAndLikes[1];
  final String likesTimes = viewAndLikes[2];

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
      color: primaryColor,
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
          // Divider(),
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

Widget createDownloadCard(
    BuildContext context, var photo, List hd4kImage, Color primaryColor) {
  String fullPhotoUrl = photo.urls.full;
  String regularPhotoUrl = photo.urls.regular;

  final String hdImage = hd4kImage[0];
  final String hdImageDesc = hd4kImage[1];
  final String s4kImage = hd4kImage[2];
  final String s4kImageDesc = hd4kImage[3];

  var card = SizedBox(
    height: 165.0,
    child: Card(
      color: primaryColor,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              _downloadNetworkImage(regularPhotoUrl, primaryColor);
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
                style: TextStyle(fontSize: 14, color: Colors.white70)),
          ),
          ListTile(
            onTap: () {
              _downloadNetworkImage(fullPhotoUrl, primaryColor);
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
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ),
        ],
      ),
    ),
  );
  return card;
}

void _downloadNetworkImage(String url, Color primaryColor) async {
  var response = await http.get(url);
  debugPrint(response.statusCode.toString());

  var filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
  var savedFile = File.fromUri(Uri.file(filePath));

  if (savedFile.toString().contains("File")) {
    String savedFilePath = "Picture Saved to: " + filePath.toString();
    print(savedFilePath);
    Fluttertoast.showToast(
        msg: savedFilePath,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        textColor: primaryColor,
        fontSize: 16.0);
  }
}
