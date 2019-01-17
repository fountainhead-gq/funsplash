import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:funsplash/api/unplash_api.dart';
import 'package:funsplash/model/category.dart';
import 'package:funsplash/utils/colors.dart';
import 'package:funsplash/ui/category_detail.dart';

class CategoryPage extends StatefulWidget {
  static const String routName = '/category';
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin {
  final Key _allTabKey = const PageStorageKey('category_list');

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Category'),
      ),
      body: new Container(
        child: FutureBuilder<List<Category>>(
          future: UnsplashApi().getCategory().then((categories) => categories
              .where((category) => category?.results != null)
              .toList()),
          // future: UnsplashApi().getCategory(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? CategoryListView(key: _allTabKey, categories: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class CategoryListView extends StatelessWidget {
  final List<Category> categories;

  const CategoryListView({Key key, @required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          // final Category category = category.results[index];
          final Category category = categories[index];

          final List<Widget> overlayTexts = [];

          overlayTexts.add(Container(height: 5.0));
          overlayTexts.add(Text(
            category.results.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
                color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600),
          ));
          overlayTexts.add(Container(height: 10.0));
          // final String description = category.results.user.name != null
          //     ? "${category.results.totalPhotos} Photos | By ${category.results.user.name}"
          //     : "${category.results.totalPhotos} Photos";
          final String description = '';
          overlayTexts.add(Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(color: Colors.white, fontSize: 16),
          ));

          return Container(
            height: 250.0,
            child: Stack(
              children: <Widget>[
                Container(
                  color: CustomColor.colorFromHex(category.results.color),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: category.results.urls.regular,
                    fadeInDuration: Duration(milliseconds: 225),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black45,
                        Colors.black26,
                        Colors.black12,
                        Colors.transparent
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: overlayTexts,
                  ),
                ),
                Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    splashColor: Colors.white10,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoryPhotosListView(category: category),
                        ),
                      );
                    },
                  ),
                ),
              ],
              fit: StackFit.expand,
              // alignment: Alignment.topLeft,
            ),
          );
        },
      );
}

class CategoryDetailsView extends StatelessWidget {
  final Category category;

  CategoryDetailsView({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "category.description",
        ),
      ),
      body: CategoryPhotosListView(category: category),
    );
  }
}
