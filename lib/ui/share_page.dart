import 'package:flutter/material.dart';

class SharePage extends StatelessWidget {
  static const String routName = '/share';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('share'),
      ),
      body: new Container(
        child: new Center(
          child: new RaisedButton(
            color: Colors.indigoAccent,
            // color: Theme.of(context).accentColor,
            elevation: 4.0,
            splashColor: Colors.blueGrey,

            child: Text('Launch screen'),
            // child: new Text(UnsplashApi().getCategories().toString()),
            // child: new Text(UnsplashApi().getPopularPhotos().toString()),
            onPressed: () {
              // Navigator.pushNamed(context, '/');
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
