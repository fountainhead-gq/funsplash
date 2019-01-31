import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:funsplash/utils/contact_url.dart';
import 'package:funsplash/utils/custom_localizations.dart';

class AboutPage extends StatefulWidget {
  static const String routName = '/About';
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final String version = FunsplashLocalizations.of(context).trans('version');
    final String aboutTitle = FunsplashLocalizations.of(context).trans('about');
    final String gitHub = FunsplashLocalizations.of(context).trans('github');
    final String author = FunsplashLocalizations.of(context).trans('author');
    final String githubDesc =
        FunsplashLocalizations.of(context).trans('github_desc');
    final String more = FunsplashLocalizations.of(context).trans('more');
    final String email = FunsplashLocalizations.of(context).trans('email');
    final String emailDesc =
        FunsplashLocalizations.of(context).trans('email_desc');
    final String enjoyApp =
        FunsplashLocalizations.of(context).trans('enjoy_app');
    final primaryColor = Theme.of(context).copyWith().primaryColor;

    return Scaffold(
      appBar: AppBar(title: new Text(aboutTitle), centerTitle: true),
      body: Scrollbar(
        child: ListView(children: <Widget>[
          new Container(
              height: 158.0,
              alignment: Alignment.center,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Card(
                    color: primaryColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: new Image.asset(
                      "assets/images/logo.png",
                      width: 100.0,
                      fit: BoxFit.fill,
                      height: 100.0,
                    ),
                  ),
                  Divider(),
                  new Text(
                    version + AppConfig.version,
                    style:
                        new TextStyle(color: Color(0xFF999999), fontSize: 14.0),
                  ),
                ],
              ),
              decoration: new BoxDecoration(
                  border:
                      new Border.all(width: 0.33, color: Color(0xffe5e5e5)))),
          new Divider(indent: 72.0, height: 0.0),
          new Container(
            child: new ListTile(
              leading: new Icon(Icons.person_outline),
              title: new Text(author),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: ContactUrl.authorGithub,
                  androidToolbarColor: primaryColor),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(
                    Icons.navigate_next,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          new Divider(indent: 72.0, height: 0.0),
          new Container(
            child: new ListTile(
              leading: new Icon(Icons.people_outline),
              title: new Text(gitHub),
              subtitle: new Text(githubDesc),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: ContactUrl.appGithub, androidToolbarColor: primaryColor),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(
                    Icons.navigate_next,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          new Divider(indent: 72.0, height: 0.0),
          new Container(
            child: new ListTile(
              leading: new Icon(Icons.mail_outline),
              title: new Text(email),
              subtitle: new Text(emailDesc),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: ContactUrl.email, androidToolbarColor: primaryColor),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(
                    Icons.navigate_next,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          new Divider(indent: 72.0, height: 0.0),
          new Container(
            child: new ListTile(
              leading: new Icon(Icons.star_border),
              title: new Text(enjoyApp),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: ContactUrl.authorStore,
                  androidToolbarColor: primaryColor),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(
                    Icons.navigate_next,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          new Divider(indent: 72.0, height: 0.0),
          new Container(
            child: new ListTile(
              leading: new Icon(Icons.apps),
              title: new Text(more),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                  url: ContactUrl.authorStore,
                  androidToolbarColor: primaryColor),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(
                    Icons.navigate_next,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          new Divider(indent: 72.0, height: 0.0),
        ]),
      ),
    );
  }
}
