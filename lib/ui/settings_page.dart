import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  static const String routName = '/settings';
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text(
          "Setting",
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          // new ExpansionTile(
          //   title: new Row(
          //     children: <Widget>[
          //       Icon(
          //         Icons.color_lens,
          //         color: Colors.grey,
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(left: 10.0),
          //         child: Text(
          //           "Theme",
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          new ListTile(
            title: new Row(
              children: <Widget>[
                Icon(
                  Icons.language,
                  color: Colors.indigo,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "language",
                  ),
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('language1',
                    style: TextStyle(
                      fontSize: 14.0,
                    )),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return null;
              }));
            },
          )
        ],
      ),
    );
  }
}
