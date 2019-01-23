import 'dart:convert' show json;
import 'package:funsplash/model/collection.dart';

class GeneratedCollection {
  int total;
  int totalPages;
  List<Collection> results;

  GeneratedCollection.fromParams({this.total, this.totalPages, this.results});

  factory GeneratedCollection(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new GeneratedCollection.fromJson(json.decode(jsonStr))
          : new GeneratedCollection.fromJson(jsonStr);

  GeneratedCollection.fromJson(jsonRes) {
    total = jsonRes['total'];
    totalPages = jsonRes['total_pages'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']) {
      results
          .add(resultsItem == null ? null : Collection.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"total": $total,"total_pages": $totalPages,"results": $results}';
  }
}
