import 'package:flutter/material.dart';
import 'package:funsplash/utils/theme_config.dart';

class ChangeThemePage extends StatefulWidget {
  static const String routName = '/Theme';
  @override
  State<StatefulWidget> createState() => ChangeThemePageState();
}

class ChangeThemePageState extends State<ChangeThemePage> {
  List<Color> colors = ThemeUtils.supportColors;

  changeColorTheme(Color c) {
    AppThemeConfig.eventBus.fire(new ChangeThemeEvent(c));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('切换主题', style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new GridView.count(
              crossAxisCount: 4,
              children: new List.generate(colors.length, (index) {
                return new InkWell(
                  onTap: () {
                    ThemeUtils.currentColorTheme = colors[index];
                    ThemeUtils.setColorTheme(index);
                    changeColorTheme(colors[index]);
                  },
                  child: new Container(
                    color: colors[index],
                    margin: const EdgeInsets.all(3.0),
                  ),
                );
              }),
            )));
  }
}
