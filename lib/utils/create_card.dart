import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_saver/image_picker_saver.dart';

Widget createDataCard(BuildContext context, var photo) {
  int likes = photo.likes;
  int downloads = photo.downloads;
  int views = photo.views;
  if (likes == null) likes = 0;
  if (downloads == null) downloads = 0;
  if (views == null) views = 0;

  var card = SizedBox(
    height: 220.0,
    child: Card(
      color: Colors.black,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.cloud_download,
              color: Colors.amber[200],
            ),
            title: Text(downloads.toString(),
                style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.amber[200],
            ),
            title: Text(likes.toString(),
                style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          ListTile(
            leading: Icon(
              Icons.remove_red_eye,
              color: Colors.amber[200],
            ),
            title: Text(views.toString(),
                style: TextStyle(fontWeight: FontWeight.w500)),
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

  var card = SizedBox(
    height: 180.0,
    child: Card(
      color: Colors.black,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              _downloadNetworkImage(regularPhotoUrl);
            },
            leading: Icon(
              Icons.hd,
              color: Colors.amber[200],
            ),
            title: Text('Full HD Image'.toString(),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            subtitle: Text('1080p image | Quick to download.',
                style: TextStyle(fontSize: 16)),
          ),
          Divider(),
          ListTile(
            onTap: () {
              _downloadNetworkImage(fullPhotoUrl);
            },
            leading: Icon(
              Icons.four_k,
              color: Colors.amber[200],
            ),
            title: Text('4K Image'.toString(),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            subtitle: Text(
              photo.width.toString() +
                  'X' +
                  photo.height.toString() +
                  ' px image | Take a while to download.',
              style: TextStyle(fontSize: 16),
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
